class CartController < ApplicationController
  def index
    # Get the cart
    # MAP each cart ID to it's model in the database (using .find )
    # return using JSON
    magazinecart = []
    session[:magazine_id].each do |x|
      magazinecart.push(Magazine.where(:id => x))
    end
    magazinedata = magazinecart.flatten
    render :json => magazinedata
  end

  def create
    sessionCart = session[:magazine_id] ||= []
    sessionCart.push(params[:id].to_i)
    # get the ID
    # add to the cart
    # render a OK status
    render :json => { :status => 200 }
  end

  def destroy
    # binding.pry
    id = params[:id].to_i
    delete_id = session[:magazine_id].find { |num| num == id }
    session[:magazine_id].delete(delete_id)
    # get the ID
    # delete from cart (take care of duplicates!)
    # render an OK status
    render :json => { :status => 200 }
  end

end
