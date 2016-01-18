class AddColumnsForOauth < ActiveRecord::Migration
  def up
    add_column :users, :provider, :string, null: false
    add_column :users, :uid, :string, null: false
    add_column :users, :username, :string, null: false

    change_column :users, :first_name, :string, null: true
    change_column :users, :last_name, :string, null: true

  end

  def down
    remove_column :users, :provider
    remove_column :users, :uid
    remove_column :users, :username

    change_column :users, :first_name, :string, null: false
    change_column :users, :last_name, :string, null: false
  end
end
