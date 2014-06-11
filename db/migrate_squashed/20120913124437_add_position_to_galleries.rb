class AddPositionToGalleries < ActiveRecord::Migration
  def up
    add_column :galleries, :position, :integer
    Vehicle.all.each do |vehicle|
      vehicle.galleries(:order => 'created_at').each_with_index do |gallery, index|
        gallery.position = index+1
        gallery.save!
      end
    end
    Vehicle.reset_column_information
  end

  def down
    remove_column :galleries, :position, :integer
  end
end
