class Pages.Users.People extends Backbone.Marionette.Layout
  template: 'pages/users/people'
  id: 'people'

  events:
    'click ul.nav-tabs li > a' : 'tabClicked'

  regions:
    followingsContent: '#followings'
    followersContent:  '#followers'

  tabClicked: Views.Mixins.tabClicked

  initialize: ({@followings, @followers, @activeTab})->
    @activeFollowingFetchrequest = 0
    @followings.each (following)=>
      @activeFollowingFetchrequest += 1
      following.thing.fetch
        success: =>
          @activeFollowingFetchrequest -= 1
          @renderFollowings()

  renderFollowings: ->
    if @activeFollowingFetchrequest is 0
      @followingsContent.show new Fragments.Users.People.Followings
        user: @model
        collection: new Backbone.Collection @followings.map (following)=> following.thing

  onRender: ->
    callback = =>
      @followersContent.show new Fragments.Users.People.Followings
        user: @model
        collection: @followers

      if @activeTab?
        @$('.nav-tabs a[data-target="#' + @activeTab + '"]').tab('show')

    setTimeout callback, 0