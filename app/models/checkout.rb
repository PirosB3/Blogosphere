class Checkout < ActiveRecord::Base
  before_create :set_sent_to_false

  attr_accessible :total_price, :stripe_transaction_id, :user, :sent
  belongs_to :user

  has_many :checkout_magazines
  has_many :magazines, :through => :checkout_magazines

  private
  def set_sent_to_false
    # Before saving lets make sure sent is set to false
    self.sent = false
  end
end
