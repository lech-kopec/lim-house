class ChangePriceToDecimalInProducts < ActiveRecord::Migration
  def up
  	change_column :products, :price, :decimal
  end

  def down
  	change_column :products, :price, :float
  end
end
