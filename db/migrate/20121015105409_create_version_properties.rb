class CreateVersionProperties < ActiveRecord::Migration
  def change
    create_table :version_properties do |t|
      t.integer :version_id
      t.integer :property_definition_id
      t.string :value

      t.timestamps
    end

    add_index :version_properties, [ :version_id, :property_definition_id ], unique: true, name: 'by_version_and_property_definition'
  end
end
