class CartController < ApplicationController

  def get_cart
    # We should use this method in every CartController action 
    # as a helper method. If the cart exists, it will fetch that
    # if not it will create a new one
    unless session[:cart_items]
      session[:cart_items] = []
    end
    return session[:cart_items]
  end

  def index
    # using normal each loop
    #magazinecart = []
    #get_cart.each do |id|
      #magazinecart.push(Magazine.find(id))
    #end

    # using MAP
    magazinecart = get_cart.map do |cart_item|
      magazine = Magazine.find(cart_item[:id]).attributes
      magazine[:purchase_type] = cart_item[:purchase_type]
      magazine
    end

    render :json => magazinecart
  end

  def create
    # get the ID, add to the cart, render a OK status
    get_cart.push(params.slice(:id, :purchase_type))
    render :json => { :status => 200 }, :status => 200
  end

  def destroy
    id_to_delete = params[:id].to_i

    # Loop through cart and delete the FIRST id that matches id_to_delete
    cart = get_cart
    cart.each_with_index do |id, index|
      if id == id_to_delete
        cart.delete_at(index)
        return render :json => { :status => 200 }, :status => 200
      end
    end
    # If the action did not return earlier, this means that
    # the item was not found. In this case we render a 500 error
    render :json => { :status => 500 }, :status => 500
  end

end

