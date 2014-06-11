Models.PropertyAttribute = Backbone.RelationalModel.extend({})


class Models.Property extends Backbone.RelationalModel
  url: ->
    versionId = @dataSheet.get('versionId')
    name      = @get('name')
    "/versions/#{versionId}/properties/#{name}"


  toJSON: ->
    property:
      name:       @get('name')
      type:       @get('type')
      attributes: @get('attributes')
