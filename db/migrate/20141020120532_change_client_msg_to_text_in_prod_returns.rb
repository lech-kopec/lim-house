class ChangeClientMsgToTextInProdReturns < ActiveRecord::Migration
  def change
  	change_column :prod_returns, :client_msg, :text, limit: nil
  end
end
