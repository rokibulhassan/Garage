class ChangePropertyAttributeForeignKey < ActiveRecord::Migration
  def up
    rename_column :property_attributes, :modification_change_id, :property_id
  end

  def down
    rename_column :property_attributes, :property_id, :modification_change_id
  end
end
