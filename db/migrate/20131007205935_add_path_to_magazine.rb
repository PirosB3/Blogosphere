class AddPathToMagazine < ActiveRecord::Migration
  def change
    add_column :magazines, :path, :string
  end
end
