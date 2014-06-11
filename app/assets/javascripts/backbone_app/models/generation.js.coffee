class Models.Generation extends Backbone.RelationalModel
  toJSON: ->
    json = super()
    delete json['number'] if isNaN parseInt json['number']
    delete json['started_at'] if isNaN parseInt json['started_at']
    delete json['finished_at'] if isNaN parseInt json['finished_at']

    json
