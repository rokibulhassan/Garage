class DropModificationPartPurchases < ActiveRecord::Migration
  def up
    drop_table :modification_part_purchases
  end

  def down
    create_table "modification_part_purchases" do |t|
      t.integer "modification_id",                     :null => false
      t.integer "part_purchase_id",                    :null => false
      t.boolean "main",             :default => false, :null => false
    end

    add_index "modification_part_purchases", ["modification_id", "part_purchase_id"], :name => "by_modification_and_part_purchase", :unique => true
  end
end
