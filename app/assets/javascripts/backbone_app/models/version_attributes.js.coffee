class Models.VersionAttributes extends Backbone.Model

  relations: [
    {
      type:           Backbone.HasOne
      key:            'version'
      relatedModel:   'Models.Version'
      includeInJSON:  false
    }
  ]

  urlRoot: ->
    "/api/version_attributes/#{@get('version').id}"