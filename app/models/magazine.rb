class Magazine < ActiveRecord::Base
  attr_accessible :image_url, :issue_number, :month, :name, :price, :type

  has_many :checkout_magazines
  has_many :checkouts, :through => :checkout_magazines
end
