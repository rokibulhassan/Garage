//= require ./identification_show
class Fragments.Vehicles.IdentificationShow.SidebarInfo extends Backbone.Marionette.Layout
  template: 'pages/vehicles/identification_show/sidebar_info'

  events:
    'click .edit-data' : 'editData'
    'click .edit-photos' : 'editPhotos'
    'click .edit-thumbnail' : 'editData'

  regions:
    'add_prewritten_comment' : '.version-add-prewritten-comment'

  initialize: ({@version, @vehicle, @versionAttributes}) ->
    @generation = @version.get('generation')
    @currentUser = Store.get('currentUser')

  onRender: ->
    callback = =>
      return unless @add_prewritten_comment
      prewrittenComments = Store.get('prewrittenVersionComments')
      if prewrittenComments
        @showPrewrittenVersionCommentsRegion(prewrittenComments)
      else
        promise = @getPrewrittenComments()
        promise.then(_.bind(@showPrewrittenVersionCommentsRegion, this))
    _.defer(callback)

  getPrewrittenComments: ->
    comments = new Collections.PrewrittenVersionComments()
    deferred = $.Deferred()
    comments.fetch success: (comments) ->
      Store.set('prewrittenVersionComments', comments)
      deferred.resolve(comments)
    deferred.promise()


  showPrewrittenVersionCommentsRegion: (prewrittenComments) ->
    region = new Fragments.Vehicles.AddPrewrittenVersionComment
      model: @version
      prewrittenComments: prewrittenComments
      currentUser: @currentUser
    @add_prewritten_comment.show region

  editData: ->
    $('.show-identification').click()
    return false

  editPhotos: ->
    $('.show-galleries').click()
    return false

  rowGroups: ->
    # [1...5] (exclusive)
    range = _.range(1, 5)
    rowGroups = []
    rowGroups.push(this['rowGroup' + i]()) for i in range
    rowGroups

  rowGroup1: ->
    [started_at, finished_at] = [@generation.get('started_at'), @generation.get('finished_at')]
    if started_at && finished_at
      suffix = " (#{started_at} - #{finished_at})"
    else
      suffix = ''

    {
      model_year: @version.get('production_year')
      generation: "#{@generation.get('number')}#{suffix}"
      model_type: @version.get('name')
    }
  rowGroup2: ->
    {
      energy: @version.get('energy')
      transmission_numbers: @version.get('transmission_numbers')
      transmission_type: @version.get('transmission_type')
    }
  rowGroup3: ->
    {
      body: @version.get('body')
      market_version: @version.get('market_version_name')
    }
  rowGroup4: ->
    ownership = @vehicle.get('ownership')
    year = ownership.get('year')
    {
      status: {
        text: ownership.get('status')
        year: year
      },
      owner_name: ownership.get('owner_name')
    }

  translateGlobalAttr: (attr, attrVal) ->
    translations = @versionAttributes.get('global_select_options_translations')?[attr]
    return attrVal unless translations?
    translatedAttrVal =  translations[attrVal]
    if translatedAttrVal?
      translatedAttrVal
    else
      attrVal

  serializeData: ->
    rowGroups: @rowGroups()
    canManage: Models.Ability.canManageVehicle(@vehicle)
    aliases: @vehicle.aliases()
    version: @version
    translateGlobalAttr: _.bind(@translateGlobalAttr, this)
    currentUser: @currentUser
