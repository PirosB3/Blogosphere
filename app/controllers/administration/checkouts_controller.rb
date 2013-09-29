class Administration::CheckoutsController < ApplicationController
    def index
           # Get a list of all the checkouts that have not been sent
        checkouts = Checkout.where(:sent => false)
        @unsent_checkouts = checkouts.select do |checkout|
            checkout.magazines.any? do |magazine|
            magazine.purchase_type == 'print'
            end
        end
    end

    def show 
        @checkout = Checkout.where(:id => params[:id])
        @user = User.where(:id => @checkout[0].user_id)
        #select all the print magazines in the purchase
        @checkout_print_magazines = @checkout[0].magazines.select do |magazine|
            magazine.purchase_type =="print"
        end

        #get the checkout_magazine and select the print ones, we dont want the e-magazines in this admin panel
        
        #get the checkout and list the transaction_id and email and the shipping address
        #Iterate through each magazine in the checkout and list the magazine issue number and whether it is sent or not, this can have the bootstrap button class
    end

    def update
        #this is going to be update, when the link is clicked then I can have a Javascript popup saying are you sure all the items in this checkout have been posted
    #Then is can update the checkouts status to sent: true and redirect_back to the checkout that it was on
    end

    
end
