class Models.DataSheet extends Backbone.RelationalModel
  relations: [
    {
      type:           Backbone.HasOne
      key:            'vehicle'
      relatedModel:   'Models.Vehicle'
      includeInJSON:  false
    }
  ]

  urlRoot: ->
    "/api/versions/#{@version_id}/data_sheet"