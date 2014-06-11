class RemoveVehicleTemplateIdFromFieldsets < ActiveRecord::Migration
  def up
    remove_column :fieldsets, :vehicle_template_id
  end

  def down
    add_column :fieldsets, :vehicle_template_id, :integer
  end
end
