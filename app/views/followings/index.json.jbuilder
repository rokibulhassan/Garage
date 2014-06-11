json.array! @followings do |json, following|
  json.partial! 'following', following: following
end