class Checkout < ActiveRecord::Base

  attr_accessible :total_price, :stripe_transaction_id, :user, :sent
  belongs_to :user

  has_many :checkout_magazines
  has_many :magazines, :through => :checkout_magazines

end
