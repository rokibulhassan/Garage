class Models.Album extends Backbone.RelationalModel
  urlRoot: '/api/albums'

  relations: [
    {
      type:            Backbone.HasMany
      key:             'pictures'
      relatedModel:    'Models.ProfilePicture'
      collectionType:  'Collections.ProfilePictures'
      includeInJSON:   false
      reverseRelation: {
        key:           'album'
        includeInJSON: false
      }
    }
    {
      type:            Backbone.HasOne
      key:             'user'
      relatedModel:    'Models.User'
      includeInJSON:   'id'
    }
  ]
