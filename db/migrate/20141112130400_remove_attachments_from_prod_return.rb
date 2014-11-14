class RemoveAttachmentsFromProdReturn < ActiveRecord::Migration
  def up
  	remove_attachment :prod_returns, :image
  end

  def down
  end
end
