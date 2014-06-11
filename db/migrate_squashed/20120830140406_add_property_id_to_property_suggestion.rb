class AddPropertyIdToPropertySuggestion < ActiveRecord::Migration
  def change
    add_column :property_suggestions, :property_id, :integer
    add_index :property_suggestions, :property_id
  end
end
