class CreateProdReturns < ActiveRecord::Migration
  def change
    create_table :prod_returns do |t|
      t.integer :user_id
      t.string :client_name
      t.string :client_msg
      t.string :auction_name
      t.date :auction_date
      t.integer :status

      t.timestamps
    end
  end
end
