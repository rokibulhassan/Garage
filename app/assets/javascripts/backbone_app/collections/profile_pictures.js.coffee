class Collections.ProfilePictures extends Backbone.Collection
  model: Models.ProfilePicture

  url: ->
    if @album
      "/api/albums/#{@album.id}/pictures"
    else if @profile
      "/api/profiles/#{@profile.id}/pictures"
    else
      "/api/profiles/pictures"


  #FIXME: no other reason to fake it than re-use of Pages.Pictures.Show view
  comparator: (model)->
    model.id
