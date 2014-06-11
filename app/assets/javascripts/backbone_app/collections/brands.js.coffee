//=require ./on_reset
class Collections.Brands extends Collections.OnReset
  model: Models.Brand
  url:   '/brands'

  comparator: (brand)->
    brand.get('label')

  byNameComparator: (brand) ->
    brand.get('name').toLowerCase()

  findByName: (name)->
    @find (brand)-> brand.get('name') == name
