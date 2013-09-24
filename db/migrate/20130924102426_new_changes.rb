class NewChanges < ActiveRecord::Migration
  def change
    remove_column :checkouts, :magazine_id
    remove_column :checkout_magazines, :purchase_type

    add_column :magazines, :purchash_type, :string

    add_column :checkouts, :address, :string
    add_column :checkouts, :post_code, :string
    add_column :checkouts, :city, :string
  end
end
