class ChangePricesPresisionInProducts < ActiveRecord::Migration
  def up
  	change_column :products, :purchase_net_euro, :decimal, :precision => 8, :scale => 2
  end

  def down
  	change_column :products, :purchase_net_euro, :decimal
  end
end
