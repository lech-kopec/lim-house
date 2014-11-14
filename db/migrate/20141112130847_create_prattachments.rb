class CreatePrattachments < ActiveRecord::Migration
  def change
    create_table :prattachments do |t|
      t.integer :prod_return_id

      t.timestamps
    end
  end
end
