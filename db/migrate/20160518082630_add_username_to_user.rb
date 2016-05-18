class AddUsernameToUser < ActiveRecord::Migration
  def change
    add_column :users, :username, :string, null: false, default: ''
    add_column :users, :visible_name, :string
  end
end
