class AddBrandToParts < ActiveRecord::Migration
  def change
    add_column :parts, :brand_id, :integer
    add_index :parts, :brand_id
  end
end
