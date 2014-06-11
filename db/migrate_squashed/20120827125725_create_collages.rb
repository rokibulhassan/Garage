class CreateCollages < ActiveRecord::Migration
  def change
    create_table :collages do |t|
      t.integer :id
      t.integer :gallery_id

      t.timestamps
    end
  end
end
