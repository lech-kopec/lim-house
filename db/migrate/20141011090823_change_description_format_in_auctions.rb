class ChangeDescriptionFormatInAuctions < ActiveRecord::Migration
  def change
  	change_column :auctions, :description, :text
  end
end
