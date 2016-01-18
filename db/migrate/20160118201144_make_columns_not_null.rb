class MakeColumnsNotNull < ActiveRecord::Migration
  def up
    change_column :users, :provider, :string, null: true
    change_column :users, :uid, :string, null: true
    change_column :users, :username, :string, null: true
  end

  def down
    change_column :users, :provider, :string, null: false
    change_column :users, :uid, :string, null: false
    change_column :users, :username, :string, null: false
  end
end
