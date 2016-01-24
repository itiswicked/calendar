class AddTimestampsWoops < ActiveRecord::Migration
  def up
    change_table :resources do |t|
      t.timestamps null: false
    end

    change_table :inventory_items do |t|
      t.timestamps null: false
    end
  end

  def down
    remove_column :resources, :created_at
    remove_column :resources, :updated_at

    remove_column :inventory_items, :created_at
    remove_column :inventory_items, :updated_at
  end
end
