Rails.configuration.stripe = {
  :publishable_key => Rails.application.credentials.stripe_key[:PUBLISHABLE_KEY],
  :secret_key      => Rails.application.credentials.stripe_key[:SECRET_KEY]
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]