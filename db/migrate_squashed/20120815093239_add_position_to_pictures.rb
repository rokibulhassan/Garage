class AddPositionToPictures < ActiveRecord::Migration
  def up
    add_column :pictures, :position, :integer
    Gallery.all.each do |gallery|
      gallery.pictures(:order => 'created_at').each_with_index do |picture, index|
        picture.position = index+1
        picture.save!
      end
    end
    Gallery.reset_column_information
  end

  def down
    remove_column :pictures, :position, :integer
  end
end
