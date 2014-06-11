class RenameFieldsetsTable < ActiveRecord::Migration
  def change
    rename_table :vehicle_template_fieldsets, :fieldsets
  end
end
