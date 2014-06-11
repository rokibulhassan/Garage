class AddFinishedToGalleries < ActiveRecord::Migration
  def change
    add_column :galleries, :finished, :boolean, null: false, default: false
  end
end
