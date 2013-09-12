class AddFieldsToCheckout < ActiveRecord::Migration
  def change
    # Checkout no longer depends from magazine
    remove_column :checkouts, :magazine

    # Price here is represented as an int, but you can easily
    # change that
    add_column :checkouts, :total_price, :integer

    add_column :checkouts, :stripe_transaction_id, :string
    add_column :checkouts, :sent, :boolean
  end
end
