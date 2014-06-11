class RenameIndexOnPropertyInPropertyAttributes < ActiveRecord::Migration
  def up
    rename_index :property_attributes, "index_property_attributes_on_modification_change_id", "index_property_attributes_on_property_id"
  end

  def down
    rename_index :property_attributes, "index_property_attributes_on_property_id", "index_property_attributes_on_modification_change_id"
  end
end
