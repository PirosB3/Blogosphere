class Administration::CheckoutsController < ApplicationController
    def index
        # Get a list of all the checkouts that have not been sent
        checkouts = Checkout.where(:sent => false)
        @unsent_checkouts = checkouts.select do |checkout|
            checkout.magazines.any? do |magazine|
            	magazine.purchase_type == 'post'
            end
        end
    end

    def show 
        @checkout = Checkout.find(params[:id])
        #select all the print magazines in the purchase
        @checkout_print_magazines = @checkout.magazines.select do |magazine|
            magazine.purchase_type =="post"
        end

        #get the checkout_magazine and select the print ones, we dont want the e-magazines in this admin panel
        
        #get the checkout and list the transaction_id and email and the shipping address
        #Iterate through each magazine in the checkout and list the magazine issue number and whether it is sent or not, this can have the bootstrap button class
    end

    def update
        checkout = Checkout.find(params[:id])
        checkout.sent = true
	checkout.save

	flash[:notice] = "You have successfully update checkout ##{checkout.id}"
        redirect_to administration_checkouts_path
        #this is going to be update, when the link is clicked then I can have a Javascript popup saying are you sure all the items in this checkout have been posted
    #Then is can update the checkouts status to sent: true and redirect_back to the checkout that it was on
    end

    
end


