class AddYoutubeStartAtAndYoutubeHdToCutout < ActiveRecord::Migration
  def change
    add_column :cutouts, :youtube_start_at, :integer
    add_column :cutouts, :youtube_hd, :boolean
  end
end
