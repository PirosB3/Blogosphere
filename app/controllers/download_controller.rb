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
  	# user = current
  end
end
