class RemoveModificationPurchase < ActiveRecord::Migration
  def up
    drop_table :modification_purchases
  end

  def down
    create_table :modification_purchases do |t|
      t.integer  :purchase_id
      t.integer  :modification_id
      t.datetime :created_at, null: false
      t.datetime :updated_at, null: false
    end
  end
end
