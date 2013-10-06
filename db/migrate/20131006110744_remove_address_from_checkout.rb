class RemoveAddressFromCheckout < ActiveRecord::Migration
  def up
    remove_column :checkouts, :address
  end

  def down
    add_column :checkouts, :address, :string
  end
end
