Pages.Users.EditMyProfile = Backbone.Marionette.ItemView.extend
  template: 'pages/edit_my_profile'

  events:
    'click ul.nav-tabs li > a' : 'tabClicked'

    'change form input'  : 'inputChanged'
    'click .edit-avatar' : 'avatarClicked'
    'change select'      : 'saveUser'

    'click .unbind-facebook' : 'unbindFacebookAccount'
    'click .bind-facebook'   : 'bindFacebookAccount'


  initialize: ({@countries, @currentTab})->
    @locales    ||= new Backbone.Collection([
      { code: "ar", label: "Arabic" },
      { code: "bg", label: "Bulgarian" },
      { code: "cs", label: "Czech" },
      { code: "da", label: "Danish" },
      { code: "en", label: "English" },
      { code: "de", label: "German" },
      { code: "es", label: "Spanish" },
      { code: "fa", label: "Persian" },
      { code: "fi", label: "Finnish" },
      { code: "fr", label: "French" },
      { code: "grc", label: "Greek" },
      { code: "hu", label: "Hungarian" },
      { code: "id", label: "Indonesian" },
      { code: "it", label: "Italian" },
      { code: "ja", label: "Japanese" },
      { code: "ko", label: "Korean" },
      { code: "nl", label: "Dutch" },
      { code: "no", label: "Norwegian" },
      { code: "pl", label: "Polish" },
      { code: "pt", label: "Portuguese" },
      { code: "ro", label: "Romanian" },
      { code: "ru", label: "Russian" },
      { code: "sk", label: "Slovak" },
      { code: "sv", label: "Swedish" },
      { code: "tr", label: "Turkish" },
      { code: "vi", label: "Vietnamese" },
      { code: "zh", label: "Chinese" }
    ])

    @currencies ||= new Backbone.Collection([
      { code: 'EUR', label: 'Euro €' },
      { code: 'USD', label: 'USD $' },
      { code: 'GBP', label: 'Pound sterling £' }
    ])

    @systemsOfUnits ||= new Backbone.Collection([
      { code: 'EU', label: 'EU' },
      { code: 'US', label: 'US' },
      { code: 'UK', label: 'UK' }
    ])

  tabClicked: (event)->
    target = $(event.target)
    tab = target.attr('href').substr(1)

    Backbone.history.navigate Routers.Main.editMyProfilePath(tab)
    target.tab('show')
    false

  unbindFacebookAccount: ->
    modal = new Modals.Users.UnbindFacebookAccount(model: @model)
    MyApp.modal.show(modal)
    false

  # TODO: use the Facebook Javascript SDK.
  bindFacebookAccount: ->
    $('<form />', action: '/facebook_sessions', method: 'POST').submit()
    false

  serializeData: ->
    user:           @model
    countries:      @countries
    locales:        @locales
    currentUser:    Store.get('currentUser')
    currencies:     @currencies
    systemsOfUnits: @systemsOfUnits

  avatarClicked: (event)->
    $('input[type=file]').click()
    false

  collectData: ->
    result =
      system_of_units_code: @$('select[name=system_of_units]').val()
      locale:               @$('select[name=locale]').val()
      country_code:         @$('select[name=country_code]').val()
      currency:             @$('select[name=currency]').val()

  saveUser: ->
    @model.save @collectData(),
      wait: true
      success: ->
        location.reload(true)

  inputChanged: (event)->
    input = event.target

    if input.name isnt ''
      @model.set input.name, if input.type == 'checkbox' then input.checked else input.value
      @model.save {}

  onRender: ->
    callback = =>
      $('select').chosen(no_results_text: ' ')

      $('input[type=file]').fileupload
        done: (event, data)=>
          avatar = data.result
          @model.set(avatarUrl: avatar.url)
          @$('.avatar img').prop('src', avatar.url)

      if @currentTab?
        @$("a[href=\"##{@currentTab}\"]").tab('show')

    setTimeout(callback, 0)
