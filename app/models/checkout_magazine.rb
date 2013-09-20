class CheckoutMagazine < ActiveRecord::Base
  belongs_to :checkout
  belongs_to :magazine
  attr_accessible :purchase_type, :checkout, :magazine
end
