class Models.Following extends Backbone.RelationalModel

  parse: (response)->
    if response.thing? and response.thing isnt 'undefined'
      type = Backbone.Relational.store.getObjectByName "Models.#{response.thing.type}"
      if type?
        thing = Backbone.Relational.store.find type, response.thing.id
        if thing? and thing isnt 'undefined'
          @thing = thing
        else
          @thing = new type(id: response.thing.id)
      else
        console.log "Unrecognized thing: %o", response.thing

      delete response['thing']

    response

  isFollow: (thing)->
    @thing isnt 'undefined' and @thing.id is thing.id and @thing instanceof thing.constructor
