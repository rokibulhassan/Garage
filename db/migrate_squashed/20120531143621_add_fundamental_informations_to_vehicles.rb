class AddFundamentalInformationsToVehicles < ActiveRecord::Migration
  def change
    add_column :vehicles, :doors_count, :integer
    add_column :vehicles, :body, :string
    add_column :vehicles, :version_id, :integer

    add_column :vehicles, :year, :integer
    add_column :vehicles, :fuel_type, :string
    add_column :vehicles, :gear_box, :string
    add_column :vehicles, :engine_id, :integer

    add_index :vehicles, :version_id
    add_index :vehicles, :engine_id
  end
end
