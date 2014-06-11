json.array! @comments do |json, comment|
  comment.each do |key, val|
    json.set!(key, val)
  end
end
