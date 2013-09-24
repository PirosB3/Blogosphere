class ApplicationController < ActionController::Base
  protect_from_forgery

   def get_cart
    # We should use this method in every CartController action 
    # as a helper method. If the cart exists, it will fetch that
    # if not it will create a new one
    unless session[:cart_items]
      session[:cart_items] = []
    end
    return session[:cart_items]
  end

  def get_cart_magazines
    get_cart.map do |id|
      Magazine.find(id)
    end
  end

  def get_cart_price
  	prices = get_cart_magazines.map do |magazine|
  		magazine.price
    end
    prices.sum
  end
end
