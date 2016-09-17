class RemoveSaltFromUsers < ActiveRecord::Migration[5.0]
  def change
    remove_column :client_manager_users, :salt
  end
end
