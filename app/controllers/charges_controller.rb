class ChargesController < ApplicationController
	def new
		binding.pry
		if params[:type] == 'print'
			# binding.pry
		    @products_total = params[:subtotal]
		    @pandp = 1.50
		    @subtotalwithpp = params[:subtotal].to_i + 1.5
		else
		    @products_total = params[:subtotal]
		    @pandp = 0
		    @subtotalwithpp = params[:subtotal]
		end
    end

	# def subtotal
	# 	binding.pry
	# end

	def create
		binding.pry
		# Set your secret key: remember to change this to your live secret key in production
		# See your keys here https://manage.stripe.com/account
		Stripe.api_key = "sk_test_aP5rgF9InbdDGENtMnZevqT4"

		# Get the credit card details submitted by the form
		token = params[:stripeToken]
		@subtotal_create = params[:subtotal]
		@subtotal = params[:subtotal].to_i * 1000
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
        
        redirect_to charges_mandrill_mailer_path
		#redirect to the the charges controller Mandrill, need to get the users email address

		# Save the customer ID in your database so you can use it later
		# save_stripe_customer_id(user, customer.id)

		# Later...
		# customer_id = get_stripe_customer_id(user)

    end

    def mandrill_mailer
    	UserMailer.welcome_email.deliver
    	render :template => 'charges/create'
    end
end
