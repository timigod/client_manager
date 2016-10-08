class AddSuperAdminFlagToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :client_manager_users, :superadmin, :boolean, default: false
  end
end
