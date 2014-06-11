# WARNING: Tend to be less used. Use collections instead.

amplify.request.define 'countries.all', 'ajax'
  url:   '/countries.json'
  cache: true


amplify.request.define 'locales.all', 'ajax'
  url:   '/locales.json'
  cache: true


amplify.request.define 'models.index', 'ajax'
  url:   '/models/{type}.json'
  cache: true


amplify.request.define 'versions.index', 'ajax'
  url:   '/versions.json'
  cache: true


amplify.request.define 'vehicles.update_attribute', 'ajax'
  url:  '/vehicles/{id}/update_attribute'
  type: 'PUT'


amplify.request.define 'vehicle.update_mosaic_avatar', 'ajax'
  url:  '/vehicles/{id}/update_mosaic_avatar'
  type: 'PUT'


amplify.request.define 'users.unbind_facebook_account', 'ajax'
  url:  '/users/{user_id}/unbind_facebook_account.json'
  type: 'PUT'


amplify.request.define 'categories.all', 'ajax'
  url:   '/categories.json'
  cache: true


amplify.request.define 'categories.all', 'ajax'
  url:   '/categories.json'
  cache: true
