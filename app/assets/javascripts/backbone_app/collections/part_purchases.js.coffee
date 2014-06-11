class Collections.PartPurchases extends Backbone.Collection
  model: Models.PartPurchase

  url: ->
    "/api/vehicles/#{@vehicle.id}/part_purchases"