class Models.Ownership extends Backbone.RelationalModel
  urlRoot: ->
    "/api/vehicles/#{@get('vehicle').id}/ownerships"

  toJSON: ->
    json = super()

    for attr in ['year_dependence', 'statuses', 'owner_names']
      delete json[attr]

    json