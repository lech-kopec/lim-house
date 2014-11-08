class DeleteAuctions < ActiveRecord::Migration
  def up
  	drop_table :auctions
  	drop_table :transactions
  end

  def down
  end
end
