class RemoveColumnsFromProducts < ActiveRecord::Migration
  def up
  	remove_column :products, :description, :status, :quantity, :image_lnk, :price
  	add_column :products, :purchase_net_euro, :decimal 
  	add_column :products, :buy_now_gross, :decimal
  	add_column :products, :delivery_cost, :decimal
  	add_column :products, :delivery_dhl_gross, :decimal
  end
end
