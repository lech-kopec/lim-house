class DeleteClients < ActiveRecord::Migration
  def up
  	drop_table :clients
  end

  def down
  end
end
