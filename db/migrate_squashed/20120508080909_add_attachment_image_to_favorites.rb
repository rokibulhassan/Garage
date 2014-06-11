class AddAttachmentImageToFavorites < ActiveRecord::Migration
  def self.up
    add_column :favorites, :image_file_name, :string
    add_column :favorites, :image_content_type, :string
    add_column :favorites, :image_file_size, :integer
    add_column :favorites, :image_updated_at, :datetime
  end

  def self.down
    remove_column :favorites, :image_file_name
    remove_column :favorites, :image_content_type
    remove_column :favorites, :image_file_size
    remove_column :favorites, :image_updated_at
  end
end
