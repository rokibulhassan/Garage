Views.Mixins.initializeSortable = ->
  if @$('ul.thumbnails').data().sortable? then return

  @$('ul.thumbnails').sortable({tolerance: 'pointer'}).singular_sortable
    positionAttribute : 'data-position'
    update: (event, ui)=>
      modelAttrs =
        position: ui.numericalPosition
      @collection.getByCid(ui.item.context.dataset.modelCid).save modelAttrs


Views.Mixins.initializeSortableItem = ->
  @$el.attr('data-position', @model.get('position'))
  @$el.attr('data-model-cid', @model.cid)
