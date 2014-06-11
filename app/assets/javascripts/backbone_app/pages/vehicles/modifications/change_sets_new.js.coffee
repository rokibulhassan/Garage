class Pages.Vehicles.Modifications.ChangeSetsNew extends Backbone.Marionette.ItemView
  template: 'pages/vehicles/modifications/change_sets_new'
  events:
    'click .save-change-set' : 'saveChangeSet'

  initialize: ({@changeSets})->

  saveChangeSet: ->
    changeSet = new Models.ChangeSet @collectData()
    changeSet.collection = @changeSets
    changeSet.save {},
      wait: true
      success: (model, response)=>
        @changeSets.add model
        @close()

    false

  collectData: ->
    name: @$('#new-change-set-name').val()