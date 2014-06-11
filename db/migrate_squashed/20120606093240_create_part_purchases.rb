class CreatePartPurchases < ActiveRecord::Migration
  def change
    create_table :part_purchases do |t|
      t.references :vehicle
      t.references :vendor
      t.references :part
      t.boolean :special, null: false, default: false
      t.float :price
      t.integer :quantity
      t.date :bought_at

      t.timestamps
    end
    add_index :part_purchases, :vendor_id
    add_index :part_purchases, :part_id
  end
end
