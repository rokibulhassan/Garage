class CreateGalleries < ActiveRecord::Migration
  def change
    create_table :galleries do |t|
      t.string :title
      t.references :cover_picture

      t.timestamps
    end
    add_index :galleries, :cover_picture_id
  end
end
