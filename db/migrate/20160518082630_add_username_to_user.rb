class AddUsernameToUser < ActiveRecord::Migration
  def change
    add_column :users, :username, :string, null: false
    add_column :users, :visible_name, :string
  end
end
