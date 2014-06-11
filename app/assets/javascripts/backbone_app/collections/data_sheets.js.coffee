class Collections.DataSheets extends Backbone.Collection
  model: Models.DataSheet

  url: ->
    "/api/models/#{@m_id}/data_sheets"
