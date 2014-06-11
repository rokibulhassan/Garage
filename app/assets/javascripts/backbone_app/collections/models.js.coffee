# NB! using CoffeeScript class raises "Uncaught TypeError: Cannot read property 'prototype' of undefined"
# TODO: possible conflict with initialization "window.Models = {}"
Collections.Models = Backbone.Collection.extend
  model: Models.Model
  url:   '/models'


  findByName: (name)->
    @find (model)-> model.get('name') == name
