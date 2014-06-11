# Don't forget to change the sizes if it change in uploader rules.
# They are there to easily set the size of image containers.
timestamp = Time.current.to_i

json.avatars do |json|
  if vehicle.avatar?
    json.normal do |json|
      json.url vehicle.avatar_url(:normal) + "?_=#{timestamp}"
    end
  else
    json.avatar nil
  end
end
