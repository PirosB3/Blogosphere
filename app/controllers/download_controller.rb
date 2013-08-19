class DownloadController < ApplicationController
  def index
  	@magazine = Magazine.all
  end

  def create_checkout
  	# binding.pry
  end
end
