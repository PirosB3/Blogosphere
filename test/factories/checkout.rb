FactoryGirl.define do
  factory :checkout do
    user
    total_price            12000
    stripe_transaction_id  'uadshiausdho'
    sent  false
  end
end

