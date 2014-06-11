# encoding: utf-8

class VehicleAvatarUploader < ImageFileUploader

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  version :normal do
    resize_to_fill(180, 135)
  end

  version :twelve_x_5 do
    resize_to_fill(324, 135)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  def filename
    "avatar.#{model.avatar.file.extension}" if original_filename
  end
end
