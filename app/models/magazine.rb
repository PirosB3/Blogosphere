class Magazine < ActiveRecord::Base
  attr_accessible :image_url, :issue_number, :month, :name, :price
end
