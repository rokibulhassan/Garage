class CreatePropertyDefinitions < ActiveRecord::Migration
  def change
    create_table :property_definitions do |t|
      t.string :name
      t.string :unit
      t.string :comparator, default: 'Comparator::Base'

      t.timestamps
    end
  end
end
