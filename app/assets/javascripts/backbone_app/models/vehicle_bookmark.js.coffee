Models.VehicleBookmark = Backbone.Model.extend
  urlRoot: ->
    "/api/vehicles/#{@get('vehicle')?.get('id')}/bookmarks"


  initialize: (attributes)->
    @set('vehicle', attributes.vehicle)


  parse: (response)->
    @id = response.vehicle.id if response.vehicle
    response
