Collections.ModificationParts = Backbone.Collection.extend
  model: Models.ModificationPart

  url: ->
    vehicle = @modification.get('vehicle')
    "/vehicles/#{vehicle.id}/modifications/#{@modification.id}/modification_parts"
