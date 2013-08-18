class DownloadController < ApplicationController
  def index
  	@magazine = Magazine.all
  end
end
