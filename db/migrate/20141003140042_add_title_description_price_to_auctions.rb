class AddTitleDescriptionPriceToAuctions < ActiveRecord::Migration
  def change
  	add_column :auctions, :title, :string
  	add_column :auctions, :description, :string
  	add_column :auctions, :price, :decimal
  end
end
