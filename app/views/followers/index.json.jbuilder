json.array! @followers do |json, follower|
  json.partial! 'follower', follower: follower
end