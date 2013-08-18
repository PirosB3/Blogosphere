class CreateMagazines < ActiveRecord::Migration
  def change
    create_table :magazines do |t|
      t.string :name
      t.integer :issue_number
      t.string :image_url
      t.integer :price
      t.string :month

      t.timestamps
    end
  end
end
