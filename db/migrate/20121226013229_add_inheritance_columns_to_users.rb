class AddInheritanceColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :user_interface_id, :integer
    add_column :users, :user_interface_type, :string
    add_index :users, [:user_interface_id, :user_interface_type], unique: true
  end
end
