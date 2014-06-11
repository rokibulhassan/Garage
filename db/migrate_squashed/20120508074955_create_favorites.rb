class CreateFavorites < ActiveRecord::Migration
  def change
    create_table :favorites do |t|
      t.string :url
      t.references :user
      t.string :label

      t.timestamps
    end
    add_index :favorites, :user_id
  end
end
