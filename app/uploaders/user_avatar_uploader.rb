class UserAvatarUploader < ImageFileUploader
  version :normal do
    resize_to_fill(100, 100)
  end
end
