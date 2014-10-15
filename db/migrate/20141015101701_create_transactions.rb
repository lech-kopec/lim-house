class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.integer :auction_id
      t.integer :client_id
      t.integer :quantity

      t.timestamps
    end
  end
end
