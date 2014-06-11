ActiveAdmin.register Version do
  menu false

  controller do
    def update
      @vehicle = Vehicle.find(params[:vehicle_id])
      if resource.update_attributes(params[:version])
        flash[:notice] = "Vehicle successfully updated"
      else
        flash[:error] = "Something went wrong..."
      end
      redirect_to admin_vehicle_url(@vehicle)
    end
  end

end
