class CreateCheckoutMagazines < ActiveRecord::Migration
  def change
    create_table :checkout_magazines do |t|
      t.references :checkout
      t.references :magazine
      t.string :purchase_type

      t.timestamps
    end
    add_index :checkout_magazines, :checkout_id
    add_index :checkout_magazines, :magazine_id
  end
end
