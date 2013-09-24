class Checkout < ActiveRecord::Base

  attr_accessible :address, :post_code, :city
  belongs_to :user

  has_many :checkout_magazines
  has_many :magazines, :through => :checkout_magazines

  validates :address, :presence => true
  validates :post_code, :presence => true
  validates :city, :presence => true

end
