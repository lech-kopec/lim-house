class AddImageLnkToProducts < ActiveRecord::Migration
  def change
    add_column :products, :image_lnk, :string
  end
end
