class AddValuesToPropertyAttributes < ActiveRecord::Migration
  def change
    add_column :property_attributes, :values, :text
  end
end
