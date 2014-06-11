ActiveAdmin.register User do
  menu priority: 18

  decorate_with UserAdminDecorator

  actions :index, :show

  filter :first_name
  filter :last_name
  filter :email
  filter :country_code
  filter :locale
  filter :created_at, label: 'registered at'

  index do
    column :avatar, sortable: false
    column :id
    column :name, sortable: false
    column :email
    column :country do |user|
      user.country_with_locale
    end
    column :registered_at, sortable: false
    column :vehicles_quantity, sortable: false
  end

  show do
    panel "User Details" do
      attributes_table_for UserAdminDecorator.new(user) do
        row :avatar
        row :id
        row :first_name
        row :last_name
        row :locale
        row :country
        row :email
        row :registered_at
      end
    end
    panel "User Vehicles" do
      table_for VehicleAdminDecorator.decorate(user.vehicles) do
        column :silhouette, sortable: false
        column :label, sortable: false
        column :body
        column :version, :version_name, sortable: false
        column :mods, sortable: false
        column :model_year, sortable: false
        column :generation, :generation_label, sortable: false
        column :production_code
      end
    end
  end
end
