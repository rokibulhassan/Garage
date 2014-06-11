class AddModificationIdAndMainToPartPurchase < ActiveRecord::Migration
  def change
    add_column :part_purchases, :main, :boolean, default: false
  end
end
