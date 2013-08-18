class CreateCheckouts < ActiveRecord::Migration
  def change
    create_table :checkouts do |t|
      t.integer :user_id
      t.integer :magazine_id

      t.timestamps
    end
  end
end
