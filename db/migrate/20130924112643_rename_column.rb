class RenameColumn < ActiveRecord::Migration
  def change
    rename_column :magazines, :purchash_type, :purchase_type
  end
end
