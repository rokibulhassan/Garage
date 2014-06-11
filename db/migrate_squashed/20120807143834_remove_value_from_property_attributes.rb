class RemoveValueFromPropertyAttributes < ActiveRecord::Migration
  def up
    remove_column :property_attributes, :value
  end

  def down
    add_column :property_attributes, :value, :string
  end
end
