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
      self.update_attribute(:stripe_response, charge.to_json)
      if JSON.parse(Payment.last.stripe_response)["paid"] && JSON.parse(Payment.last.stripe_response)["paid"] == true
      	#payment successfully processed, send email with download link
      	puts "Payment success"

        self.generate_link

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

  def generate_link
    l = self.links.new(:url => self.product.s3_download_path, :expiry => Time.now + ENV['file_expiry_hours'].to_i.hours)
    l.save
  end

end
