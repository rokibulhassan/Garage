class Pages.Vehicles.Modifications.ModificationsNew extends Backbone.Marionette.ItemView
  template: 'pages/vehicles/modifications/modifications_new'
  events:
    'click .save-modification' : 'saveModification'

  initialize: ({@modifications})->

  saveModification: ->
    modification = new Models.Modification @collectData()
    modification.collection = @modifications
    modification.save {},
      wait: true
      success: (model, response)=>
        @modifications.add model
        @close()

    false

  collectData: ->
    name: @$('#new-modification-name').val()