class UpdateSideviews < ActiveRecord::Migration
  def up
    SideView.find_each do |side_view|
      side_view.image.resize_img(:large)
      def side_view.image_changed?() true end
      side_view.send(:save_image_dimensions)
      side_view.save
    end
  end

  def down
  end
end
