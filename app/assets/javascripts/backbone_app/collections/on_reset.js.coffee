Collections.OnReset = Backbone.Collection.extend
  constructor: ()->
    Backbone.Collection.apply(this, arguments)

    @onResetCallbacks = new Backbone.Marionette.Callbacks
    @on "reset", @collectionReset, @

  onReset: (callback) ->
    @onResetCallbacks.add callback
    @collectionLoaded and @fireResetCallbacks()

  collectionReset: ->
    @collectionLoaded = true  unless @collectionLoaded
    @fireResetCallbacks()

  fireResetCallbacks: ->
    @onResetCallbacks.run @
