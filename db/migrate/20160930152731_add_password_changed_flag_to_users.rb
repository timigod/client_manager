class AddPasswordChangedFlagToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :client_manager_users, :password_changed, :boolean, default: false
  end
end
