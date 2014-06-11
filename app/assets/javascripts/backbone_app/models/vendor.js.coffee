class Models.Vendor extends Backbone.RelationalModel
  url: ->
    if @isNew() then '/vendors'
    else "/vendors/#{@id}"


  save: ->
    $.post(@url(), @saveData(), @saveCallback())


  toJSON: ->
    name:         @get('name')
    website:      @get('website')
    street:       @get('street')
    zipcode:      @get('zipcode')
    city:         @get('city')
    country_code: @get('country')?.code


  saveData: ->
    data = { vendor: @toJSON() }
    data._method = 'PUT' unless @isNew()
    data


  saveCallback: ->
    return(->) unless @isNew()
    (vendor)=> @set('id', vendor.id)
