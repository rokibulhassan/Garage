class AddSideViewIdToVehicles < ActiveRecord::Migration
  def change
    add_column :vehicles, :side_view_id, :integer
  end
end
