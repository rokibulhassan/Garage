Modals.Vehicles.CropMosaicImage = Backbone.Marionette.ItemView.extend
  template: 'modals/vehicles/crop_mosaic_image'

  events:
    'click a.btn' : 'cropImage'
    'change input[name=style]' : 'changeAspectRatio'


  style: 'narrow'

  aspectRatios:
    narrow: 169/130
    large:  346/130


  changeAspectRatio: (event)->
    @style       = event.target.value
    @aspectRatio = @aspectRatios[@style]
    @$('#image-to-crop').Jcrop(aspectRatio: @aspectRatio)


  cropImage: (event)->
    if @crop && @crop.width
      data = { id: @model.get('id'), crop: @crop, style: @style }
      amplify.request 'vehicle.update_mosaic_avatar', data, (response)=>
        @model.set(response)
        MyApp.layout.content.currentView.render()

      @trigger('close')

    false


  serializeData: ->
    vehicle: @model


  onRender: ->
    @initializeJcrop()


  initializeJcrop: ->
    that = @

    callback = ->
      $img = that.$('img#image-to-crop')
      $img.Jcrop
        aspectRatio: that.aspectRatios[that.style]
        bgOpacity:   0.3
        onSelect:    _.bind(that.coordinatesChanged, that)
        onChange:    _.bind(that.coordinatesChanged, that)

    setTimeout(callback, 0)


  coordinatesChanged: (coordinates)->
    @crop =
      width:  coordinates.w
      height: coordinates.h
      x:      coordinates.x
      y:      coordinates.y
