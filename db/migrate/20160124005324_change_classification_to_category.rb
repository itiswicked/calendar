class ChangeClassificationToCategory < ActiveRecord::Migration
  def change
    rename_column :inventory_items, :classification, :category
  end
end
