class Collections.Corrections extends Backbone.Collection
  model: Models.Correction

  url: ->
    "/api/corrections?version_property_id=#{@version_property_id}"
