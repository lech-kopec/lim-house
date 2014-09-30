class CreateAuctions < ActiveRecord::Migration
  def change
    create_table :auctions do |t|
      t.integer :product_id
      t.integer :quantity
      t.integer :status

      t.timestamps
    end
    add_index :auctions, [:product_id, :created_at]
  end
end
