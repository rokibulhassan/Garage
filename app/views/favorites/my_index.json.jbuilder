json.array! @favorites do |json, favorite|
  json.extract! favorite, :id, :created_at, :label

  json.urls do |json|
    json.source    favorite.page_url
    json.original  favorite.image.url
    json.thumbnail favorite.image.url(:thumbnail)
  end
end
