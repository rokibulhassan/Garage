class CreateChangeSetProperties < ActiveRecord::Migration
  def change
    create_table :change_set_properties do |t|
      t.references :change_set, null: false
      t.references :property_definition, null: false
      t.boolean :advantage, default: true
      t.timestamps
      t.string :value
    end
  end
end
