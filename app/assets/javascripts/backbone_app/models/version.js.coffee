class Models.Version extends Backbone.RelationalModel
  urlRoot: '/api/versions'

  relations: [
    {
      type:           Backbone.HasMany
      key:            'propertyInstances'
      relatedModel:   'Models.PropertyInstance'
      collectionType: 'Collections.VersionPropertyInstances'
      reverseRelation:
        key: 'version'
    }
    {
      type:         Backbone.HasOne
      key:          'generation'
      relatedModel: 'Models.Generation'
      includeInJSON: false
      reverseRelation:
        type:          Backbone.HasOne
        key:           'version'
        includeInJSON: 'id'
        keySource:     'version_id'
    }
  ]


  initialize: ->
    dataSheet = new Models.DataSheet
    dataSheet.version_id = @id
    @set 'data_sheet', dataSheet


  parse: (response)->
    response.data_sheet = new Models.DataSheet
    response.data_sheet.version_id = response.id
    response

  toJSON: ->
    json = super()
    delete json['production_year'] if isNaN parseInt json['production_year']
    delete json['production_code'] unless json['production_code']

    json

  globalAttributes: [
    'body', 'doors', 'transmission_numbers', 'transmission_type', 'transmission_details', 'energy'
  ]
