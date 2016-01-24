class CreateInventory < ActiveRecord::Migration
  def change
    create_table :inventory_items do |t|
      t.string :name, null: false
      t.string :classfication, null: false
    end
  end
end
