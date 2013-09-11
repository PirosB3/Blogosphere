class Checkout < ActiveRecord::Base
  before_create :set_sent_to_false

  attr_accessible :user, :total_price, :stripe_transaction_id
  has_many :users

  private
  def set_sent_to_false
    # Before saving lets make sure sent is set to false
    self.sent = false
  end
end
