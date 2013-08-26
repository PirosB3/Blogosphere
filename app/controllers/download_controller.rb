class DownloadController < ApplicationController
  def index
  	@magazine = Magazine.all
  end

  def show
  	if user_signed_in?
	  	@user = current_user
	  	respond_to do |format|
	    format.html
	    format.json { render :json => @user}
	    end
	end
  end

  def create_checkout
  	@user = current_user
    @id = params[:id]
    @checkout = Checkout.create(:magazine_id => params[:id], :user_id => current_user.id)
  end

  def destroy_checkout
    @magazine = Magazine.where(:name => params[:magazine_name])
    # binding.pry
    @checkout = Checkout.where(:user_id => current_user.id, :magazine_id => @magazine[0].id)
    @checkout.destroy_all
  end
end
