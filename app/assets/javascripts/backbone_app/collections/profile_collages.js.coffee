Collections.ProfileCollages = Backbone.Collection.extend
  model: Models.ProfileCollage

  url: ->
    "/api/profiles/#{@profile.id}/collages"
