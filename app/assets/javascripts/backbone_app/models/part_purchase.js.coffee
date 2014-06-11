class Models.PartPurchase extends Backbone.RelationalModel
  defaults:
    quantity: 1
    special:  false
    price:    0

  relations: [
    {
      type: Backbone.HasOne
      key: 'part'
      relatedModel: 'Models.Part'
      includeInJSON: 'id'
      keyDestination: 'part_id'
    }
    {
      type: Backbone.HasOne
      key: 'vendor'
      relatedModel: 'Models.Vendor'
      includeInJSON: 'id'
      keyDestination: 'vendor_id'
    }
  ]