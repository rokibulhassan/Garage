class AddModificationToPartPurchase < ActiveRecord::Migration
  def change
    add_column :part_purchases, :modification_id, :integer
    add_index :part_purchases, :modification_id
  end
end
