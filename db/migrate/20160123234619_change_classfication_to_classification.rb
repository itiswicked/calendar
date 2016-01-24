class ChangeClassficationToClassification < ActiveRecord::Migration
  def change
    rename_column :inventory_items, :classfication, :classification
  end
end
