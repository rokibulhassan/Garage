class CreateUnitTypes < ActiveRecord::Migration
  def change
    create_table :unit_types do |t|
      t.string :label_fr
      t.string :label_en
      t.string :kind

      t.timestamps
    end
  end
end
