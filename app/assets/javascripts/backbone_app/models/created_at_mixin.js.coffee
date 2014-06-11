Models.CreatedAtMixin =
  initializeCreatedAt: ->
    @set('created_at', new Date(@get('created_at')))


  parse: (response)->
    response.created_at = new Date(response.created_at)
    response


  formattedCreatedAt: ->
    $.datepicker.formatDate($.datepicker._defaults.dateFormat, @get('created_at'))
