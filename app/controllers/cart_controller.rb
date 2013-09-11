class CartController < ApplicationController

  def get_cart
    unless session[:cart_items]
      session[:cart_items] = []
    end
    return session[:cart_items]
  end

  def index
    #magazinecart = []
    #get_cart.each do |id|
      #magazinecart.push(Magazine.find(id))
    #end

    # OR using MAP
    magazinecart = get_cart.map do |id|
      Magazine.find(id)
    end

    render :json => magazinecart
  end

  def create
    # get the ID
    # add to the cart
    # render a OK status
    get_cart.push(params[:id].to_i)
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
    render :json => { :status => 500 }, :status => 500
  end

end

