class AddMediaTypeAndVideoIdToPictures < ActiveRecord::Migration
  def change
    add_column :pictures, :media_type, :string, default: 'picture'
    add_column :pictures, :video_id, :string
  end
end
