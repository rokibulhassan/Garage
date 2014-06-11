class Collections.Versions extends Backbone.Collection
  model: Models.Version
  url:   '/api/versions'


  findByName: (name)->
    @find (model)-> model.get('name') == name
