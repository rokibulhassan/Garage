class Pages.Dashboard.NewsFeedsItemLayout extends Backbone.Marionette.Layout
  template: 'pages/dashboard/news_feeds/layout'
  tagName: 'li'
  className: 'news-item'

  events:
    'click .name a' : 'goToProfile'

  regions:
    content: '.content'

  onRender: ->
    @content.show new Pages.Dashboard.NewsFeedsItem model: @model

  goToProfile: (e) ->
    userId = $(e.currentTarget).data('user-id')
    userId ||= @model.get('initiator').id
    Backbone.history.navigate Routers.Main.showUserProfilePath(userId), true
    false

  serializeData: ->
    initiator:    @model.get('initiator')
    last_updated: @model.get('updated_at').substring(10, 0)
    event_type:   @model.get('event_type')
    extra:        @model.get('target').extra
