class SetPricesPrecisionsInProducts < ActiveRecord::Migration
  def up
	change_column :products, :purchase_net_euro, :decimal, :precision => 10, :scale => 3
	change_column :products, :buy_now_gross, :decimal, :precision => 10, :scale => 3
	change_column :products, :delivery_cost, :decimal, :precision => 10, :scale => 3
	change_column :products, :delivery_dhl_gross, :decimal, :precision => 10, :scale => 3
  end

  def down
  	change_column :products, :purchase_net_euro, :decimal
  	change_column :products, :buy_now_gross, :decimal
  	change_column :products, :delivery_cost, :decimal
  	change_column :products, :delivery_dhl_gross, :decimal
  end
end
