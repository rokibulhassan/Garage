Modals.Vehicles.ChangeMainUser = Backbone.Marionette.ItemView.extend
  template: 'modals/vehicles/change_main_user'

  events:
    'click a' : 'linkClicked'


  linkClicked: (event)->
    $link = $(event.currentTarget)
    name  = $link.data('user')
    label = $link.text().trim()

    usedBy = @model.get('ownership').get('usedBy') || {}
    @model.persistAttribute('main_user', name, 'string')
    MyApp.modal.close()
    false
