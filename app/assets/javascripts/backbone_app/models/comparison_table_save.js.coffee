class Models.ComparisonTableSave extends Backbone.RelationalModel
  urlRoot: '/api/comparison_tables/'
  url: ->
    @urlRoot + @get('comparison_table_id') + '/' + 'save'
