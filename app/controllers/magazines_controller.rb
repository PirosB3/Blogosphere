class MagazinesController < ApplicationController

  def index
    @magazines = Magazine.all
  end

end
