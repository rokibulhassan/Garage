class CreateChangeSets < ActiveRecord::Migration
  def change
    create_table :change_sets do |t|
      t.string :name, null: false
      t.references :vehicle
      t.timestamps
    end
  end
end
