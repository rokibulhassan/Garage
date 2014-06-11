class Collections.ComparisonTables extends Backbone.Collection
  model: Models.ComparisonTable

  url: ->
    "/api/comparison_tables"