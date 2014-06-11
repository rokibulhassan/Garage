class RemoveUnitFromPropertyDefinitions < ActiveRecord::Migration
  def up
    remove_column :property_definitions, :unit
  end

  def down
    add_column :property_definitions, :unit, :string
  end
end
