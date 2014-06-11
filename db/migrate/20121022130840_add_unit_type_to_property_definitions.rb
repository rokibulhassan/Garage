class AddUnitTypeToPropertyDefinitions < ActiveRecord::Migration
  def change
    add_column :property_definitions, :unit_type, :string
  end
end
