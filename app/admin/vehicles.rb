ActiveAdmin.register Vehicle do
  menu priority: 6

  decorate_with VehicleAdminDecorator

  config.clear_sidebar_sections!
  actions :index, :show, :approve, :update, :destroy

  controller do
    def scoped_collection
      Vehicle.includes({version: [{model: :brand}, :generation]}, :side_view, :user, :modifications)
    end
  end

  member_action :approve do
    if resource.version.approve
      flash[:notice] = "Successfully approved"
      redirect_to admin_vehicle_url(resource)
    else
      flash[:error] = "Approving error"
      render :show
    end
  end

  index do
    column :silhouette, sortable: false do |vehicle|
      link = link_to(I18n.t('active_admin.delete'),
              admin_vehicle_path(vehicle),
              method: :delete, data: {confirm: I18n.t('active_admin.delete_confirmation')}, class: "member_link delete_link")

      "#{vehicle.silhouette} #{link}".html_safe
    end
    column :label, sortable: false
    column :body
    column :version, :version_name, sortable: false
    column :mods, sortable: false
    column :model_year, sortable: false
    column :generation, :generation_label, sortable: false
    column :production_code
    column :user, sortable: false
    column :locale, sortable: false
  end

  show  do
    panel "Vehicle Details" do
      render 'vehicle_form', vehicle: vehicle, decorated_vehicle: VehicleAdminDecorator.new(vehicle)
    end

    panel "Vehicle Specification" do
      render 'vehicle_properties', vehicle: vehicle, decorated_vehicle: VehicleAdminDecorator.new(vehicle)
    end

    if vehicle.version.unapproved?
      panel "Approve" do
        attributes_table_for vehicle do
          row :assign_to_existing_version do
            semantic_form_for [:admin, vehicle], url: nil do |f|
              f.input(:version,
                      as: :select,
                      collection: Version.approved,
                      label: false,
                      member_label: :full_label,
                      member_value: :id,
                      input_html: {class: 'chosen' }) +

              f.actions do
                f.action(:submit, label: "Assign version")
              end
            end
          end

          row :create_new do
            semantic_form_for [:admin, vehicle], url: url_for(action: :approve) do |f|
              f.actions do
                f.action(:submit, label: "Approve current version")
              end
            end
          end
        end
      end
    end
  end
end
