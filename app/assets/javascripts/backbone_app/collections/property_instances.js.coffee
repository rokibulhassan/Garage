# Used as base class for with having property instances.
Collections.PropertyInstances = Backbone.Collection.extend
  findByName: (propertyName)->
    @find (propertyInstance)->
      propertyInstance.get('property').get('name') == propertyName


Collections.VersionPropertyInstances = Collections.PropertyInstances.extend
  url: -> "/versions/#{@version.id}/property_instances"


Collections.RevisionPropertyInstances = Collections.PropertyInstances.extend({})
