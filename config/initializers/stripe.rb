Rails.configuration.stripe = {
  :publishable_key => ENV['stripe_publishable_key'],
  :secret_key      => ENV['stripe_api_key']
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]