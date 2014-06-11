//= require ./modifications_item
class Pages.Vehicles.Modifications.ChangeSetItem extends Backbone.Marionette.ItemView
  template: 'pages/vehicles/modifications/change_set_item'
  className: 'tab-pane'
  events:
    'click .combine-mods'           : 'saveChangeSet'
    'click .delete-change-set'      : 'deleteChangeSet'
    'click .set-current-change-set' : 'setCurrent'

  initialize: ({@modifications})->

  serializeData: ->
    modifications: @modifications
    change_set:    @model
    showControls:  Models.Ability.canManageChangeSet @model

  onRender: ->
    @$el.attr 'id',"change_set_#{@model.id}"

    @prependChangeSetItem()

    @setAfterCallBacks()

  saveChangeSet: ->
    @model.save @collectData(),
      success: =>
        @prependChangeSetItem()

  collectData: ->
    modification_ids: @$("#change_set_#{@model.id}_modifications").val()

  deleteChangeSet: ->
    @model.destroy()

  setCurrent: ->
    @model.get('vehicle').save { current_change_set_id: @model.id }, silent: true

    false

  prependChangeSetItem: ->
    new Pages.Vehicles.Modifications.ModificationsItem(
      el:           @$(".change-set-modification")
      model:        @model
      showControls: false
    ).render()

  setAfterCallBacks: ->
    callbacks = => @$('select').chosen(no_results_text: ' ')
    setTimeout callbacks, 0
