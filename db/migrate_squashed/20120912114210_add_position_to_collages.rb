class AddPositionToCollages < ActiveRecord::Migration
  def up
    add_column :collages, :position, :integer
    Gallery.all.each do |gallery|
      gallery.collages(:order => 'created_at').each_with_index do |collage, index|
        collage.position = index+1
        collage.save!
      end
    end
    Gallery.reset_column_information
  end

  def down
    remove_column :collages, :position, :integer
  end
end
