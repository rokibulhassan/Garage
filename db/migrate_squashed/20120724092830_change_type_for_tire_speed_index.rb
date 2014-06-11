class ChangeTypeForTireSpeedIndex < ActiveRecord::Migration
  def up
    change_column :data_sheets, :tire_speed_index, :string
  end

  def down
    change_column :data_sheets, :tire_speed_index, :float
  end
end
