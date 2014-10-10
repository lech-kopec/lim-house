class AddAuctionLinkToAuctions < ActiveRecord::Migration
  def change
  	add_column :auctions, :web_link, :string
  end
end
