class Models.ModelSelectOption extends Backbone.RelationalModel

  url: ->
    "/api/models/#{@get('model_id')}/update_model_select_options"

  # always send PUT requests
  isNew: -> false
