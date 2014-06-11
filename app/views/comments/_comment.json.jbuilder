json.id         comment.id
json.body       comment.body
json.created_at comment.created_at
json.edited     comment.edited?
json.recent     comment.recent?

json.user do |json|
  json.id         comment.user_id
  json.username   comment.user.username
  json.avatar_url comment.user.avatar_url
end
