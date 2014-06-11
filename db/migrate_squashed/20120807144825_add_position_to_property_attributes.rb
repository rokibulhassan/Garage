class AddPositionToPropertyAttributes < ActiveRecord::Migration
  def change
    add_column :property_attributes, :position, :integer
  end
end
