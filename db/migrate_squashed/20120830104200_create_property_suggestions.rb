class CreatePropertySuggestions < ActiveRecord::Migration
  def change
    create_table :property_suggestions do |t|
      t.references :version
      t.references :property_instance
      t.integer :upvotes_count

      t.timestamps
    end
    add_index :property_suggestions, :version_id
    add_index :property_suggestions, :property_instance_id
  end
end
