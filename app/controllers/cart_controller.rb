class CartController < ApplicationController
  def index
    # Get the cart
    # MAP each cart ID to it's model in the database (using .find )
    # return using JSON

    example_data = [
      {
        :id => 1,
        :name => 'MAGAZINE 1',
        :price => 300
      },
      {
        :id => 2,
        :name => 'MAGAZINE 2',
        :price => 100
      },
      {
        :id => 3,
        :name => 'MAGAZINE 3',
        :price => 500
      }
    ]
    render :json => example_data
  end

  def create
    # get the ID
    # add to the cart
    # render a OK status
    render :json => { :status => 200 }
  end

  def destroy
    # get the ID
    # delete from cart (take care of duplicates!)
    # render an OK status
    render :json => { :status => 200 }
  end

end
