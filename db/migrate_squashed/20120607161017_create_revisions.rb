class CreateRevisions < ActiveRecord::Migration
  def change
    create_table :revisions do |t|
      t.references :vehicle
      t.integer :index
      t.date :date

      t.timestamps
    end
    add_index :revisions, :vehicle_id
  end
end
