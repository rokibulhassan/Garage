class CreateCorrections < ActiveRecord::Migration
  def change
    create_table :corrections do |t|
      t.integer :version_property_id
      t.integer :corrector_id
      t.string :value

      t.timestamps
    end
  end
end
