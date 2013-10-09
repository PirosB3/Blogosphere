class MagazinesController < ApplicationController
  def index

    # There is an inconsistency with your template and your action here.
    # looks like magazine is not being set, this renders an empty download/index page.

    @magazine = Magazine.all
  end

  def purchased
    #why does this not work!!
    #check each checkout to see if magazine contains an e-book
    checkout_with_e_book = current_user.checkouts.select do |checkout|
      checkout.magazines.any? do |magazine|
      magazine.purchase_type == 'e-book'
      end
    end

    @purchased_e_magazine = []
    #This method can be improved - it is iterating through each checkout and each magazine and pushing it into an array if it is an e-magazine
    e_magazines = checkout_with_e_book.each do |checkout|
      checkout.magazines.each do |magazine|
        if magazine.purchase_type =="e-book"
           @purchased_e_magazine << magazine
        end
      end
    end
  end

  def show

  end

end
