class CreateModificationPurchases < ActiveRecord::Migration
  def change
    create_table :modification_purchases do |t|
      t.references :purchase
      t.references :modification

      t.timestamps
    end
    add_index :modification_purchases, :purchase_id
    add_index :modification_purchases, :modification_id
  end
end
