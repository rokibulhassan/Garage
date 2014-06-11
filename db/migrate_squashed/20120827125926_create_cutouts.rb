class CreateCutouts < ActiveRecord::Migration
  def change
    create_table :cutouts do |t|
      t.integer :id
      t.integer :collage_id
      t.integer :row
      t.integer :col
      t.string :image
      t.text :crop

      t.timestamps
    end
  end
end
