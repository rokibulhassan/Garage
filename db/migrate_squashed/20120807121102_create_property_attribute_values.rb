class CreatePropertyAttributeValues < ActiveRecord::Migration
  def change
    create_table :property_attribute_values do |t|
      t.string :value
      t.references :property_attribute
      t.references :property_instance

      t.timestamps
    end
    add_index :property_attribute_values, :property_attribute_id
    add_index :property_attribute_values, :property_instance_id
  end
end
