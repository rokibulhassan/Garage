class Pages.Dashboard.Show extends Backbone.Marionette.Layout
  template: 'pages/dashboard/show'

  regions:
    news: "#news"

  initialize: ({ @newsFeeds, @myNews })->
    @page = 1

  onRender: ->
    @news.show new Pages.Dashboard.NewsFeeds
      collection: @newsFeeds
    _.defer =>
      $('.news-item').each (idx, el) =>
        return if idx >= 10
        $el = $(el)
        if $el.find('.dashboard-comparison-images').length
          $container = $el.find('.news-feed-item-container')
          $container.addClass('in-view')
          $container.trigger('in-view')
    @setBindings()

  setBindings: ->
    $(window).on 'scroll', _.throttle( =>
      if $(window).scrollTop() >= $(document).height() - $(window).height() - 10
        @loadNewsFeeds()

      @$('.dashboard-comparison-images').each (idx, el) =>
        $el = $(el)
        $p = $el.parent()
        if @isElementInViewport($p[0])
          unless $p.hasClass('in-view')
            $p.addClass('in-view')
            $p.trigger('in-view')
        else
          $p.removeClass('in-view')
    , 1000)

    @oldFXInterval = $.fx.interval
    $.fx.interval = 40

  isElementInViewport: (el) ->
    rect = el.getBoundingClientRect()
    return (
        rect.top >= 0 &&
        rect.left >= 0 &&
        rect.bottom <= (window.innerHeight || document. documentElement.clientHeight) &&
        rect.right <= (window.innerWidth || document. documentElement.clientWidth)
    )

  onClose: ->
    $(window).off 'scroll'
    $.fx.interval = @oldFXInterval

  loadNewsFeeds: ->
    return if @fetchingScrollData
    @fetchingScrollData = true
    promise = @newsFeeds.fetch
      data: {page: @page + 1, my: @myNews}
      add: true
    promise.done (collection, response, options) =>
      unless _.isEmpty(collection)
        @page += 1
    promise.complete =>
      @fetchingScrollData = false

  serializeData: ->
    myNews: @myNews
