class AddYoutubeVideoIdToCutout < ActiveRecord::Migration
  def change
    add_column :cutouts, :youtube_video_id, :string
  end
end
