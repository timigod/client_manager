# This migration comes from client_manager (originally 20160822112804)
class CreateClientManagerClients < ActiveRecord::Migration[5.0]
  def change
    create_table :client_manager_clients do |t|
      t.string :name
      t.string :token
      t.integer :user_id

      t.timestamps
    end
  end
end
