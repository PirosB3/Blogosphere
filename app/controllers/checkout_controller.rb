class CheckoutController < ApplicationController
	before_filter :authenticate_user!, :only => [:create]

	def get_purchase_information
		@to_purchase_magazines = get_cart_magazines
		@total_price_magazines = get_cart_price

		@has_at_least_a_post = @to_purchase_magazines.any? do |magazine|
			magazine.purchase_type == 'print'
		end
		@packaging_price = @has_at_least_a_post ? 2 : 0

		@subtotal = @total_price_magazines + @packaging_price
	end

	def new
		get_purchase_information
		@checkout = Checkout.new
	end

	def create
		binding.pry
		get_purchase_information
		@checkout = Checkout.new(params[:checkout])
		@checkout.is_by_post = @has_at_least_a_post
		unless @checkout.valid?
			return render 'new'
		end

		# Create a Customer
		customer = Stripe::Customer.create(
			:card => params[:stripeToken],
			:description => current_user.email
		)

		# Charge the Customer instead of the card
		charge = Stripe::Charge.create(
			:amount => @subtotal + 100,
			:currency => "gbp",
			:customer => customer.id
		)
		unless charge.paid
			flash[:alert] = "There has been a problem processing your request"
			return render root_path
		end

		@checkout.user = current_user
		@checkout.stripe_transaction_id = charge.id
		@checkout.total_price = @subtotal
		@checkout.sent = false
		@checkout.save

		@to_purchase_magazines.each do |magazine|
			@checkout.magazines.push(magazine)
			@checkout.save
		end

			
		has_at_least_a_e_magazine = @to_purchase_magazines.any? do |magazine|
										 	magazine.purchase_type == 'e-book'
										end
		mandrill_mailer(has_at_least_a_e_magazine, @checkout.stripe_transaction_id)
		
	end

	def mandrill_mailer(checkout_type, transaction_id)
		@checkout_transaction_id = transaction_id
		@checkout_type = checkout_type
		user_email = current_user.email
		UserMailer.welcome_email(user_email, @checkout_type, @checkout_transaction_id).deliver
		render :template => 'checkout/create'
	end
end
