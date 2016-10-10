class CreateClientManagerUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :client_manager_users do |t|
      t.string :name
      t.string :email
      t.integer :maximum_number_of_clients

      t.timestamps
    end
  end
end
