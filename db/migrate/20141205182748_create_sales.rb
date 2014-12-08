class CreateSales < ActiveRecord::Migration
  def change
    create_table :sales do |t|
      t.string :title
      t.decimal :price
      t.integer :quantity
      t.integer :status

      t.timestamps
    end
  end
end
