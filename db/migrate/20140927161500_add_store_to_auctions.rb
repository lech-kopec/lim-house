class AddStoreToAuctions < ActiveRecord::Migration
  def change
    add_column :auctions, :store, :string
  end
end
