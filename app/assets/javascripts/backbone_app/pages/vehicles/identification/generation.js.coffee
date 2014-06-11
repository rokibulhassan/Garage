//=require ./version

class Fragments.Vehicles.Identification.Version.Generation extends Backbone.Marionette.ItemView
  template: 'fragments/vehicles/generation'

  events:
    'change .generation-attribute' : 'saveGenerationYears'
    'change #generation_number_id' : 'saveGenerationNumber'

  initialize: ({@generations, @showControls})->
    @defaultNumberSet = _.range(1, 11)
    @numberSet     = _.uniq @generations.pluck('number')
    @defaultYears  = _.range(1920, (new Date().getFullYear() + 2)).reverse()
    @startedAtSet  = _.uniq @generations.pluck('started_at')
    @finishedAtSet = _.uniq @generations.pluck('finished_at')

  onRender: ->
    callback = =>
      @$('.chosen').chosen no_results_text: ' '
    setTimeout callback, 0

  saveGenerationNumber: ->
    sameGeneration = @generations.find (generation)=>
      generation isnt @model and generation.get('number') is @model.get('number')

    data = if sameGeneration?
      number:      @$('#generation_number_id').val()
      started_at:  sameGeneration.get('started_at')
      finished_at: sameGeneration.get('finished_at')
    else
      number:      @$('#generation_number_id').val()
      started_at:  @$('#generation_started_at_id').val()
      finished_at: @$('#generation_finished_at_id').val()

    @model.save data, silent: true, success: =>
      @render()

  saveGenerationYears: ->
    @model.save @collectData(), wait: true

  clearDates: ->
    @started_at_set  = []
    @finished_at_set = []

  collectData: ->
    started_at:  @$('#generation_started_at_id').val()
    finished_at: @$('#generation_finished_at_id').val()

  serializeData: ->
    generation:   @model
    showControls: @showControls
    numbers:      @defaultNumberSet
    startedAts:   @defaultYears
    finishedAts:  @defaultYears
