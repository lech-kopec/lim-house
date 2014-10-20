class RemoveClientMsgLimitInProdReturns < ActiveRecord::Migration
  def up
  	change_column :prod_returns, :client_msg, :text, limit: nil
  end

  def down
  	change_column :prod_returns, :client_msg, :text
  end
end
