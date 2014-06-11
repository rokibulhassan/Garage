class VersionAttributesController < ApplicationController
  load_resource class: Version, instance_name: :version

  def show
    @version_attributes = VersionAttributesCollector.new(@version).attributes params[:attributes]
  end

end
