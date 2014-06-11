//= require ./identification_show
class Fragments.Vehicles.IdentificationShow.Mosaic extends Backbone.Marionette.ItemView
  template: 'pages/vehicles/identification_show/mosaic'

  onRender: ->
    @collage = @model.get('collage')
    @collage.modeEdit = @canManage()
    view = new Fragments.CollagesItem(model: @collage, modeEdit: @collage.modeEdit)
    @$('ul.collages').append(view.render().el)
    @$('.carousel-controls').remove()

  canManage: ->
    Models.Ability.canManageVehicle(@model)
