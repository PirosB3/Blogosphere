class CheckoutController < ApplicationController
	def new
    @to_purchase_magazines = get_cart_magazines
    @total_price_magazines = get_cart_price

    @has_at_least_a_post = @to_purchase_magazines.any? do |magazine|
      magazine.purchase_type == 'post'
    end
    @packaging_price = @has_at_least_a_post ? 5000 : 0

    @subtotal = @total_price_magazines + @packaging_price
  end

	def create
		binding.pry
		# Set your secret key: remember to change this to your live secret key in production
		# See your keys here https://manage.stripe.com/account
		Stripe.api_key = "sk_test_aP5rgF9InbdDGENtMnZevqT4"

		# Get the credit card details submitted by the form
		token = params[:stripeToken]
		@subtotal = 10000
		# @subtotal = params[:subtotal].to_i * 1000
		# binding.pry

		# Create a Customer
		customer = Stripe::Customer.create(
		  :card => token,
		  :description => "payinguser@example.com"
		)

		# Charge the Customer instead of the card
		Stripe::Charge.create(
		    :amount => @subtotal, # in cents, is currently in pounds need to change
		    :currency => "gbp",
		    :customer => customer.id
		)
		binding.pry
		
        
        redirect_to checkout_mandrill_mailer_path
        #I need to pass to the mailer whether the checkout was print or e-book - emails need to be sent out accordingly
		#redirect to the the charges controller Mandrill, need to get the users email address

		# Save the customer ID in your database so you can use it later
		# save_stripe_customer_id(user, customer.id)

		# Later...
		# customer_id = get_stripe_customer_id(user)

    end

    def mandrill_mailer
    	UserMailer.welcome_email.deliver
    	render :template => 'checkout/create'
    end
end
