class AddTypeToMagazine < ActiveRecord::Migration
  def change
    add_column :magazines, :type, :string
  end
end
