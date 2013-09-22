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

  def get_cart_price
    prices = get_cart.map do |cart_item|
      Magazine.find(cart_item[:id]).price
    end
    prices.sum
  end

end
