Collections.UserVehicles = Collections.OnReset.extend({
  model: Models.Vehicle

  url: ->
    "/api/users/#{@user.id}/vehicles"

  withAvatar: ->
    models = @select (vehicle)-> !!vehicle.get('avatarUrl')
    new Collections.UserVehicles(models)
}, {
  search: (params)->
    vehiclesSearch = new Models.VehiclesSearch
    vehiclesSearch.save params, {
      success: (model, response)=>
        foundVehicles = new Collections.UserVehicles(response)
        MyApp.vent.trigger("vehicles:search:results", foundVehicles)
      error: =>
        console.log 'vehicle:search:error'
    }


  bookmarks: (results, params)->
    bookmarkedVehiclesSearch = new Models.VehiclesSearch
      bookmarks: 'yes'
    bookmarkedVehiclesSearch.save params, {
      success: (model, response)=>
        results.reset(response)
      error: =>
        console.log 'vehicle:bookmarked:error'
    }
})
