class AddTitleToVehicleTemplates < ActiveRecord::Migration
  def change
    add_column :vehicle_templates, :title, :string
  end
end
