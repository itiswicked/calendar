class CreateResources < ActiveRecord::Migration
  def change
    create_table :resources do |t|
      t.belongs_to :event, null: false
      t.belongs_to :inventory_item, null: false
      t.integer :quantity, null: false
    end
  end
end
