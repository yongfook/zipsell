class Payment < ApplicationRecord
	serialize :stripe_params
  serialize :stripe_response
  belongs_to :product
  belongs_to :customer
  has_many :links
  after_create :process
  validates_presence_of :product_id
  validates_uniqueness_of :number
  has_unique_number :number, generator: :payments, type: :sequential, format: 'P#y#m#d-%i', start_value: 8, reset: :monthly
  acts_as_hashids length: 10
  monetize :amount_cents

  def process
    return if !self.stripe_response.blank?
    return if !self.stripe_params[:stripeToken]
    begin
      # Token is created using Checkout or Elements!
      # Get the payment token ID submitted by the form:
      token = self.stripe_params[:stripeToken]

      # Charge the user's card:
      charge = Stripe::Charge.create(
        :amount => self.product.price_cents,
        :currency => self.product.price.currency,
        :description => "#{self.product.downloadtype} - #{self.product.name}",
        :source => token,
      )
      self.update_attribute(:stripe_response, JSON.parse(charge.to_json))
      if self.stripe_response["paid"] && self.stripe_response["paid"] == true
      	#payment successfully processed, send email with download link
      	puts "Payment success"

        self.generate_link

        #update amount column
        self.amount_cents = self.stripe_response["amount"]
        self.amount_currency = self.stripe_response["currency"]
        self.save
        
        #send email to customer
        ApplicationMailer.customer_new_payment(self.id).deliver

        #send email to admin
        ApplicationMailer.admin_new_payment(self.id).deliver
      end
    rescue => ex
      #logger.error ex.message
      puts "Stripe API error!"
      puts "#{ex.message}"
    end

  end

  def generate_and_send_new_link
    self.generate_link
    ApplicationMailer.customer_new_link(self.id).deliver
  end

  def generate_link
    l = self.links.new(:url => self.product.s3_download_path, :expiry => Time.now + ENV['file_expiry_hours'].to_i.hours)
    l.save
  end

  def self.get_sum_for_last_n_days(n = 0)
    return Payment.all.sum(:amount_cents) / 100 if n == 0
    date = Time.now - n.days
    return Payment.where("created_at >= '#{date}'").sum(:amount_cents) / 100
  end

end
