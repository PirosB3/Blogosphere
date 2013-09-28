class Administration::CheckoutsController < ApplicationController
    def index
           # Get a list of all the checkouts that have not been sent
        checkouts = Checkout.where(:sent => false)
        @unsent_checkouts = checkouts.select do |checkout|
            checkout.magazines.any? do |magazine|
            magazine.purchase_type == 'print'
            end
        end

    def show
    end
    end
end
