class SideViewImageUploader < ImageFileUploader


  PIXEL_RATIO = { Vehicle::AUTOMOBILE   => 21,
                  Vehicle::MOTORCYCLE   => 29 }

  version :large
  version :thumb, :from => :large do
    process :half_size
  end

  def geometry
    @geometry ||= get_geometry
  end

  def get_geometry
    if @file
      img = ::Magick::Image::read(@file.file).first
      geometry = { width: img.columns, height: img.rows }
    end
  end

  def filename
    "side_view.#{model.image.file.extension}" if original_filename
  end

  def half_size
    scale = if model.version.vehicle_type == Vehicle::AUTOMOBILE
      0.57
    else
      0.50
    end
    manipulate! do |img|
      img.scale(scale)
    end
  end

  def resize
    return unless model && model.version

    manipulate! do |img|
      length =  model.version.properties.find_by_name('length').value_object.to('m').scalar

      width = PIXEL_RATIO[model.version.model.vehicle_type] * length

      img.resize width / img.columns
    end
  end
end
