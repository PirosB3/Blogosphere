require 'test_helper'

class UserTest < ActiveSupport::TestCase
   test "it can assert what magazines are available to the user" do
     user = FactoryGirl.create(:user)

     m1 = FactoryGirl.create(:magazine, :name => 'Magazine 1')
     m2 = FactoryGirl.create(:magazine, :name => 'Magazine 2')
     m3 = FactoryGirl.create(:magazine, :name => 'Magazine 3')

     checkout1 = FactoryGirl.create(:checkout, :user => user)
     checkout2 = FactoryGirl.create(:checkout, :user => user)
     [m1, m3].each do |m|
       CheckoutMagazine.create( :checkout => checkout1, :magazine => m, :purchase_type => :web)
     end
     CheckoutMagazine.create(
       :checkout => checkout2,
       :magazine => m2,
       :purchase_type => :ebook
     )

     purchased_magazines = user.checkout_magazines
     assert_equal purchased_magazines.length, 3

     magazines = user.magazines
     assert_equal magazines.length, 3
     magazines.each do |magazine|
       assert magazine.name.start_with? 'Magazine'
     end

   end
end
