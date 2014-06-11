Collections.UserPictures = Backbone.Collection.extend
  model: Models.UserPicture

  url: ->
    "/api/users/#{@user.id}/pictures"

  #FIXME: no other reason to fake it than re-use of Pages.Pictures.Show view
  comparator: ->
    1
