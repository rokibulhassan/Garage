class CreateUnitSystems < ActiveRecord::Migration
  def change
    create_table :unit_systems do |t|
      t.string :label_fr
      t.string :label_en
      t.string :name

      t.timestamps
    end
  end
end
