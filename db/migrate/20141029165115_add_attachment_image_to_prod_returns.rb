class AddAttachmentImageToProdReturns < ActiveRecord::Migration
  def self.up
      add_attachment :prod_returns, :image
  end

  def self.down
    remove_attachment :prod_returns, :image
  end
end
