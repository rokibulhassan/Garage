class CreateSideViews < ActiveRecord::Migration
  def change
    create_table :side_views do |t|
      t.string :image
      t.timestamps
    end
  end
end
