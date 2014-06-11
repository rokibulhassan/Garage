class Pages.Dashboard.NewsFeedsItem extends Backbone.Marionette.ItemView

  getTemplate: ->
    "pages/dashboard/news_feeds/#{@model.get('event_type')}"

  events:
    'click .go-to-gallery'    : 'goToGallery'
    'click .go-to-comparison' : 'goToComparison'
    'click .go-to-new-vehicle': 'goToNewVehicle'

  className: 'news-feed-item-container'

  initialize: ({})->
    @extra = @model.get('target').extra

  onRender: ->
    @startComparisonSlideshow()
    @eventTypeContainers = []
    @currentlyAnimating = false
    @setBindings()
    setTimeout =>
      $eventTypes = @$('.dashboard-event-type')
      $eventTypes.each (i, eventType) =>
        $eventType = $(eventType)
        $eventTypeContainer = $eventType.closest('.content').
          siblings('.newsfeed-event-first-line').find('.dashboard-event-type-container')
        @eventTypeContainers.push($eventTypeContainer)
        $eventTypeContainer.append($eventType)
        $eventTypeContainer.find('.go-to-gallery').on('click', _.bind(this['goToGallery'], this))
        @populateComparisonTab()
    , 0

  onClose: ->
    _.each @eventTypeContainers, ($container) ->
      $container.off()
    @$el.off('in-view')

  setBindings: ->
    @$el.on 'in-view', =>
      @currentlyAnimating = false
      @startComparisonSlideshow()

  goToGallery: ->
    Backbone.history.navigate Routers.Main.showVehicleGalleryPath({
      id: @extra['gallery_id'],
      vehicle: { id: @extra['vehicle_id'] }
    }), true
    false

  goToComparison: ->
    path = if @model.get('initiator').id is Store.get('currentUser').id
      Routers.Main.showMyComparisonPath(@model.get('target').id)
    else
      Routers.Main.showUserComparisonPath(@model.get('initiator'), @model.get('target').id)

    Backbone.history.navigate(path, true)
    false

  goToNewVehicle: (e) ->
    $target = $(e.currentTarget)
    Backbone.history.navigate(
      Routers.Main.showVehicleIdentificationPath($target.data('vehicle-id')),
      true
    )
    false

  populateComparisonTab: ->
    numVehicles = @model.get('vehicles').size()
    @$el.closest('.item-content').find('.dashboard-comparison-tab .num-vehicles').text(numVehicles)

  startComparisonSlideshow: (delay = 2000) ->
    setTimeout(_.bind(@doStartComparisonSlideShow, this), delay)

  doStartComparisonSlideShow: ->
    if !@$el.hasClass('in-view') or @currentlyAnimating
      return false
    @currentlyAnimating = true

    $vehicle3 = @$('.vehicle-3')
    $vehicle2 = @$('.vehicle-2')
    $vehicle1 = @$('.vehicle-1')

    return unless $vehicle3.length

    vehicle2OrigPos = $vehicle2.data('orig-pos')
    vehicle3OrigPos = $vehicle3.data('orig-pos')
    $vehicle2Info = $vehicle1.siblings(".vehicle-#{vehicle2OrigPos}-info").first()
    $vehicle3Info = $vehicle1.siblings(".vehicle-#{vehicle3OrigPos}-info").first()
    @$('.current-info-bottom,.current-info-top').removeClass('current-info-bottom current-info-top')
    $vehicle2Info.fadeIn(1500).addClass('current-info-bottom')
    $vehicle3Info.fadeIn(1500).addClass('current-info-top')

    $vehicle3Img = $vehicle3.find('img')
    $vehicle2Img = $vehicle2.find('img')
    $vehicle1Img = $vehicle1.find('img')

    vehicle3Width  = parseInt($vehicle3Img.css('width'))
    vehicle3WidthNext = vehicle3Width / 0.75
    vehicle3Height = parseInt($vehicle3Img.css('height'))
    vehicle2Width  = parseInt($vehicle2Img.css('width'))
    vehicle2WidthNext = vehicle2Width / 0.75
    vehicle2Height = parseInt($vehicle2Img.css('height'))
    vehicle1Width  = parseInt($vehicle1Img.css('width'))
    vehicle1WidthNext = vehicle1Width / 0.75
    vehicle1Height = parseInt($vehicle1Img.css('height'))

    $vehicle3.show().animate({left: "#{if vehicle3WidthNext >= 135 then 135 - vehicle3WidthNext else Math.abs(135 - vehicle3WidthNext)}px", bottom: '25px'}, 2000)
    @animateGrowImage($vehicle3Img, vehicle3Width, vehicle3Height, 0.75, 2000, { opacity: 1 })

    $vehicle2.animate({left: "#{if vehicle2WidthNext >= 85 then 85 - vehicle2WidthNext else Math.abs(85 - vehicle2WidthNext)}px", bottom: '0'}, 2000)
    @animateGrowImage($vehicle2Img, vehicle2Width, vehicle2Height, 0.75, 2000)

    $vehicle1.animate({left: "#{if vehicle1WidthNext >= 20 then 20 - vehicle1WidthNext else Math.abs(20 - vehicle1WidthNext)}px", bottom: '-30px', opacity: 0}, 2000)
    @animateGrowImage($vehicle1Img, vehicle1Width, vehicle1Height, 0.75, 2000, { opacity: 0 })

    $vehicle1.fadeOut 2000, =>
      @shrinkImage($vehicle1Img, vehicle1Width, vehicle1Height, Math.pow(0.75, 2), {opacity: 0})
      newVehicle1Width = parseInt($vehicle1Img.css('width'))
      $vehicle1.css({left: "#{if newVehicle1Width >= 175 then 175 - newVehicle1Width else Math.abs(175 - newVehicle1Width)}px", bottom: '45px', opacity: 1})
      $vehicle2Info.delay(1000).fadeOut(1000)
      $vehicle3Info.delay(1000).fadeOut(1000)

      last = @lastVehicleNum($vehicle3)
      if last > 3
        range = _.range(4, last + 1).reverse()
        @moveDownClass($vehicle3.siblings(".vehicle-#{i}").first()) for i in range

      @moveDownClass($vehicle1)
      @moveDownClass($vehicle2)
      @moveDownClass($vehicle3)
      @currentlyAnimating = false
      @startComparisonSlideshow()

  moveDownClass: ($vehicle) ->
    return unless $vehicle
    previousNum = parseInt(/vehicle-(\d)/.exec($vehicle.attr('class'))[1])
    newNum = if previousNum is 1
              @lastVehicleNum($vehicle)
            else
              previousNum - 1
    $vehicle.removeClass("vehicle-#{previousNum}").addClass("vehicle-#{newNum}")

  lastVehicleNum: ($vehicle) ->
    $vehicle.closest('.dashboard-comparison-images').data('last-vehicle-num')

  animateGrowImage: ($img, origWidth, origHeight, amt = 0.75, len = 2000, properties = {}) ->
    defaults = { width: "#{origWidth / amt}px", height: "#{origHeight / amt}px" }
    defaults = _.extend(defaults, properties)
    $img.animate(defaults, len)

  growImage: ($img, origWidth, origHeight, amt = 0.75, properties = {}) ->
    defaults = { width: "#{origWidth / amt}px", height: "#{origHeight / amt}px" }
    _.extend(defaults, properties)
    $img.css(defaults)

  shrinkImage: ($img, origWidth, origHeight, amt = 0.75, properties = {}) ->
    @growImage($img, origWidth, origHeight, 1 / amt, properties)

  serializeData: ->
    news_feed: @model
    extra: @extra
