class CreatePropertyAttributes < ActiveRecord::Migration
  def change
    create_table :property_attributes do |t|
      t.string :name
      t.string :value
      t.string :type
      t.references :modification_change

      t.timestamps
    end
    add_index :property_attributes, :modification_change_id
  end
end
