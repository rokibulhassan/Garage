class PictureImageUploader < ImageFileUploader

  # Create different versions of your uploaded files:
  version :thumb, :from_version => :big do
    resize_to_fill(180, 135)
  end

  # 240x135 and 80x45 for gallery creation pictures on dashboard
  version 'sixteen_x_9', :from_version => :big do
    resize_to_fill(400, 225)
  end

  version 'sixteen_x_9_small', :from_version => :sixteen_x_9 do
    resize_to_fill(80, 45)
  end

  version 'twelve_x_5', :from_version => :big do
    resize_to_fill(324, 135)
  end

  version :big do
    process :rotate
    resize_to_limit(1600, 1200)
    process :store_big_dimensions
    process :blur
  end

  def uploads_subdir
    'picture'
  end

  def store_big_dimensions
    manipulate! do |img|
      if model
        model.send("#{mounted_as}_big_width=".to_sym, img.columns)
        model.send("#{mounted_as}_big_height=".to_sym, img.rows)
      end
      img = yield(img) if block_given?
      img
    end
  end

  def rotate
    if model && !model.new_record? && model.respond_to?(:rotate)
      manipulate! do |img|
        rotation = model.send("#{mounted_as}_rotation")
        img.rotate(rotation)
      end
    end
  end

  def blur
    manipulate! do |img|
      if model && model.respond_to?(:blur) && model.blur
        model.send("#{mounted_as}_blur_areas").each do |coords|
          tile_size = ([img.rows, img.columns].max / 50).round
          new_area = img
            .crop(coords[:x], coords[:y], coords[:w], coords[:h])
            .scale(1.0/tile_size)
            .scale(tile_size)
            .resize(coords[:w], coords[:h])
          img.composite!(new_area, coords[:x], coords[:y], Magick::AtopCompositeOp)
        end
      end
      img
    end
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  def filename
    "#{mounted_as}1.#{model.image.file.extension}" if original_filename
  end
end
