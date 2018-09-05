class Payment < ApplicationRecord
	serialize :stripe_params
  serialize :stripe_response
  belongs_to :product
  after_create :process
  validates_presence_of :product_id

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
      end
    rescue => ex
      #logger.error ex.message
      puts "Stripe API error!"
      puts "#{ex.message}"
    end

  end

end
