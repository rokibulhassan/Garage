class RenameConsumptionTables < ActiveRecord::Migration
  def up
    rename_column :data_sheets, :construction_highway, :consumption_highway
    rename_column :data_sheets, :construction_combined, :consumption_combined
  end

  def down
    rename_column :data_sheets, :consumption_highway, :construction_highway
    rename_column :data_sheets, :consumption_combined, :construction_combined
  end
end
