class RemoveAttachmentFileFromPicture < ActiveRecord::Migration
  def up
    remove_column :pictures, :image_file_name
    remove_column :pictures, :image_content_type
    remove_column :pictures, :image_file_size
    remove_column :pictures, :image_updated_at
  end

  def down
    add_column :pictures, :image_file_name, :string
    add_column :pictures, :image_content_type, :string
    add_column :pictures, :image_file_size, :integer
    add_column :pictures, :image_updated_at, :datetime
  end
end
