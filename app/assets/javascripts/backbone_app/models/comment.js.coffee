//= require ./created_at_mixin
//= require ./linkified_mixin
Models.Comment = Backbone.RelationalModel.extend

  initialize: ->
    _.extend @, Models.CreatedAtMixin
    _.extend @, Models.LinkifiedMixin
    @initializeCreatedAt()


  linkifiedBody: ->
    @linkified @get('body')
