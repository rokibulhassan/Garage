Modals.Revisions ||= {}
Modals.Revisions.New = Backbone.Marionette.ItemView.extend
  template: 'modals/revisions/new'

  events:
    'change #label'         : 'changeLabel'
    'change #base-revision' : 'changeBaseRevision'
    'click .save-revision'  : 'saveRevision'


  initialize: (attributes)->
    @revision  = new Models.Revision
    @revisions = attributes.revisions


  saveRevision: ->
    @revisions.add(@revision)
    @revision.save {},
      success: =>
        @trigger('revision:created', @revision)
    @close()
    false


  changeLabel: (event)->
    @revision.set(label: event.target.value)


  changeBaseRevision: (event)->
    console.log revision = @revisions.get(event.target.value)
    @revision.set(baseRevision: revision)


  serializeData: ->
    revisions: @revisions


  onRender: ->
    callback = -> @$('select').chosen(no_results_text: ' ')
    setTimeout(callback, 0)
