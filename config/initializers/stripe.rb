Rails.configuration.stripe = {
  :publishable_key => ENV['pk_test_cjMKtqKqJv1rcWEzUinqNbiL'],
  :secret_key      => ENV['sk_test_aP5rgF9InbdDGENtMnZevqT4']
}

Stripe.api_key = Rails.configuration.stripe[:sk_test_aP5rgF9InbdDGENtMnZevqT4]