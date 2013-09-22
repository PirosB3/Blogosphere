class CheckoutController < ApplicationController

  def new
    @cart_items = get_cart.map do |cart_item|
      magazine = Magazine.find(cart_item[:id]).attributes
      magazine['purchase_type'] = cart_item[:purchase_type]
      magazine
    end
    @cart_count = @cart_items.length
    @cart_price = get_cart_price
  end

  def create
  end

end
