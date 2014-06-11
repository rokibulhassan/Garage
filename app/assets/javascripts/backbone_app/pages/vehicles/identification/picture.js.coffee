//=require ./identification
class Fragments.Vehicles.Identification.Picture extends Backbone.Marionette.Layout
  template: 'fragments/vehicles/picture'

  events:
    'click .change' : 'changePictureClicked'

  onRender: ->
    callback = =>
      @initializeFileUpload()

    setTimeout callback, 0

  initializeFileUpload: ->
    $f = @$('input[type=file]').fileupload()
    $f.on 'fileuploaddone', (event, data)=>
      @model.save data.result,
        wait: true
        success: =>
          Backbone.history.navigate "#{Routers.Main.showVehiclePath @model}/specifications", true

  serializeData: ->
    vehicle:      @model
    showPicture:  Models.Ability.canShowVehiclePicture @model
    showControls: Models.Ability.canManageVehicle @model

  changePictureClicked: ->
    @$('input[type=file]').click()
    false