require "stripe"
Stripe.api_key = Rails.configuration.stripe["private_key"]
