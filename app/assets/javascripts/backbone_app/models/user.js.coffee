class Models.User extends Backbone.RelationalModel
  relations: [
    {
      type:           Backbone.HasMany
      key:            'vehicles'
      relatedModel:   'Models.Vehicle'
      collectionType: 'Collections.UserVehicles'
      includeInJSON:  'id'
      reverseRelation:
        key: 'user'
        keyDestination: 'user_id'
        includeInJSON:  'id'
    }
    {
      type:            Backbone.HasMany
      key:             'comments'
      relatedModel:    'Models.Comment'
      collectionType:  'Collections.Comments'
      includeInJSON:   false
      reverseRelation:
        key:            'user'
        keyDestination: 'user_id'
        includeInJSON:  'id'
    }
    {
      type:            Backbone.HasMany
      key:             'followings'
      relatedModel:    'Models.Following'
      collectionType:  'Collections.Followings'
      includeInJSON:   false
      reverseRelation:
        key:            'user'
        keyDestination: 'user_id'
        includeInJSON:  'id'
    }
    {
      type:            Backbone.HasMany
      key:             'followers'
      relatedModel:    'Models.Follower'
      collectionType:  'Collections.Followers'
      includeInJSON:   false
      reverseRelation:
        key:            'user'
        keyDestination: 'user_id'
        includeInJSON:  false
    }
    {
      type:            Backbone.HasMany
      key:             'news_feeds'
      relatedModel:    'Models.NewsFeed'
      collectionType:  'Collections.NewsFeeds'
      includeInJSON:   false
      reverseRelation:
        key:            'listener'
        keySource:      'listener_id'
        keyDestination: 'listener_id'
        includeInJSON:  false
    }
    {
      type:            Backbone.HasMany
      key:             'collages'
      relatedModel:    'Models.ProfileCollage'
      collectionType:  'Collections.ProfileCollages'
      includeInJSON:   false
      reverseRelation:
        key:            'profile'
        keyDestination: 'profile_id'
        includeInJSON:  'id'
    }
    {
      type:            Backbone.HasMany
      key:             'pictures'
      relatedModel:    'Models.UserPicture'
      collectionType:  'Collections.UserPictures'
      includeInJSON:   false
      reverseRelation:
        key:            'user'
        keyDestination: 'user_id'
        includeInJSON:  'id'
    }
    {
      type:            Backbone.HasMany
      key:             'profile_pictures'
      keyDestination:  'pictures_attributes'
      relatedModel:    'Models.ProfilePicture'
      collectionType:  'Collections.ProfilePictures'
      reverseRelation:
        key:            'profile'
        keyDestination: 'profile_id'
        includeInJSON:  'id'
    }
  ]

  urlRoot: '/api/users'

  toJSON: ->
    json = super()
    delete json['comparisonTables'] if isNaN parseInt json['comparisonTables']
    delete json['bookmarkedVehicles'] if isNaN parseInt json['bookmarkedVehicles']

    json

  # TODO: change method name to `isFollowing`
  isAlreadyFollows: (thing)->
    @get('followings').find((following)-> following.isFollow(thing))?

  fullName: ->
    $.trim "#{(@get('first_name') || '')} #{(@get('last_name') || '')}"
