class Checkout < ActiveRecord::Base

	attr_accessor :is_by_post
  attr_accessible :post_code, :city, :address_line_1, :address_line_2, :county, :country
  belongs_to :user

  has_many :checkout_magazines
  has_many :magazines, :through => :checkout_magazines

  validates :address_line_1, :presence => true, :unless => :magazines_all_ebooks
  validates :post_code, :presence => true, :unless => :magazines_all_ebooks
  validates :city, :presence => true, :unless => :magazines_all_ebooks

	private
	def magazines_all_ebooks
		!@is_by_post
	end

end
