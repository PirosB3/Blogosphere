class AddDetailsToCheckout < ActiveRecord::Migration
  def change
    add_column :checkouts, :address_line_1, :string
    add_column :checkouts, :address_line_2, :string
    add_column :checkouts, :county, :string
    add_column :checkouts, :country, :string
  end
end
