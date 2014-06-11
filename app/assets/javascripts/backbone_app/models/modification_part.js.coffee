class Models.ModificationPart extends Backbone.RelationalModel
  relations: [
    {
      type:         Backbone.HasOne
      key:          'part'
      relatedModel: 'Models.Part'
    }
  ]