json.array! @side_views do |json, side_view|
  json.partial! 'side_view', side_view: side_view
end