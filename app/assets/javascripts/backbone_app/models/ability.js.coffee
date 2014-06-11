class Models.Ability extends Backbone.Model
  @canManageUser: (user)->
    currentUserId = Store.get('currentUser')?.id

    if currentUserId and user instanceof Models.User
      user.id == currentUserId
    else
      false

  @canManageVehicle: (vehicle)->
    currentUserId = Store.get('currentUser')?.id

    if currentUserId and vehicle instanceof Models.Vehicle
      userId = vehicle.get('user')?.id

      userId == currentUserId
    else
      false

  @canShowVehiclePicture: (vehicle)->
    vehicle.get('version').get('full_identity_data')

  @canShowVehicleSideView: (vehicle)->
    vehicle.get('approved')

  @canGetToTab: (vehicle, tabName)->
    switch tabName
      when 'identification'
        true
      when 'specifications'
        # TODO: change this?
        vehicle.normalAvatarUrl() isnt ''
      else
        #vehicle.get('approved')
        true

  @canShowIdentificationRow: (vehicle, row)->
    false unless vehicle instanceof Models.Vehicle

    switch row
      when 'body'
        if vehicle.isAuto()
          [model, attribute] = [vehicle.get('version'), 'doors']
        else
          return true
      when 'modelVersion'
        [model, attribute] = [vehicle.get('version'), 'body']
      when 'market'
        [model, attribute] = [vehicle.get('version'), 'name']
      when 'productionCode', 'productionYear'
        if (!vehicle.get('version').get('name'))
          return false
        [model, attribute] = [vehicle.get('version'), 'market_version_name']
      when 'generation', 'gearBox'
        [model, attribute] = [vehicle.get('version'), 'production_year']
      when 'gearBoxType'
        [model, attribute] = [vehicle.get('version'), 'transmission_numbers']
      when 'transmission', 'ownership'
        [model, attribute] = [vehicle.get('version'), 'transmission_type']
      when 'energy'
        [model, attribute] = [vehicle.get('version'), 'transmission_details']

    model.get(attribute)? and $.trim(model.get(attribute)) isnt ""

  @canImportDataSheet: (dataSheet)->
    return false unless dataSheet instanceof Models.DataSheet
    true

  @canManageComparisonTable: (comparisonTable)->
    currentUserId = Store.get('currentUser')?.id
    if currentUserId and comparisonTable instanceof Models.ComparisonTable
      userId = comparisonTable.get('user')?.id
      userId == currentUserId
    else
      false

  @canManagePicture: (picture)->
    if picture instanceof Models.UserPicture ||
       picture instanceof Models.VehicleIdentificationPicture
      return Models.Ability.canManageUser(picture.get('user'))
    if picture instanceof Models.ProfilePicture
      return Models.Ability.canManageUser(picture.get('profile'))
    if picture instanceof Models.VehicleGalleryPicture
      return Models.Ability.canManageVehicle(picture.get('vehicle'))
    if picture instanceof Models.Picture
      return Models.Ability.canManageVehicle(picture.get('gallery').get('vehicle'))
    false

  @canManageComment: (comment)->
    currentUserId = Store.get('currentUser')?.id
    if currentUserId and comment instanceof Models.Comment
      userId = comment.get('user').id
      userId == currentUserId and comment.get('recent')
    else
      false

  @canFollow: (thing)->
    if thing instanceof Models.User
      currentUser = Store.get('currentUser')
      thing.id != currentUser and !currentUser.isAlreadyFollows(thing)
    else
      false

  @canAddToOpposers: (userName)->
    currentUserName = Store.get('currentUser')?.get('username')
    currentUserName and currentUserName != userName

  @canDeleteModification: (modification, changeSets)->
    changeSets? and @canManageVehicle(modification.get('vehicle')) and !changeSets.any (changeSet)=> changeSet.get('modifications').contains(modification)

  @canManageChangeSet: (changeSet)->
    @canManageVehicle changeSet.get 'vehicle'

  @canManageAlbum: (album)->
    currentUserId = Store.get('currentUser')?.id
    currentUserId and album instanceof Models.Album and currentUserId == album.get('user')?.id
