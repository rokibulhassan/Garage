class AddTitlesToVehicleTemplateFieldsets < ActiveRecord::Migration
  def change
    add_column :vehicle_template_fieldsets, :title_en, :string
    add_column :vehicle_template_fieldsets, :title_fr, :string
  end
end
