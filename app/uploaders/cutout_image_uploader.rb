class CutoutImageUploader < ImageFileUploader
  version :collage do
    process :crop
  end

  def crop
    if model && model.crop
      manipulate! do |img|
        coords = model.crop
        dimensions = model.dimensions
        img
          .crop(coords[:x], coords[:y], coords[:w], coords[:h])
          .resize_to_fit(dimensions[:w], dimensions[:h])
      end
    end
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  def filename
    "#{mounted_as}.#{model.image.file.extension}" if original_filename
  end
end
