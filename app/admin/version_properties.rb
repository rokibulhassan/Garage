ActiveAdmin.register VersionProperty do
  menu false

  controller do
    def update
      @vehicle = Vehicle.find(params[:vehicle_id])
      resource.attributes = params[:version_property]
      resource.actor = @vehicle.user
      resource.actor.as_admin = true
      if resource.save
        flash[:notice] = "Vehicle successfully updated"
      else
        flash[:error] = "Something went wrong..."
      end
      redirect_to admin_vehicle_url(@vehicle)
    end
  end

end
