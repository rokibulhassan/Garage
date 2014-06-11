class CreatePropertyInstances < ActiveRecord::Migration
  def change
    create_table :property_instances do |t|
      t.references :property
      t.integer :resource_with_property_id
      t.string :resource_with_property_type

      t.timestamps
    end
    add_index :property_instances, [ :resource_with_property_id, :resource_with_property_type ], name: 'index_property_instances_on_resource_with_property'
  end
end
