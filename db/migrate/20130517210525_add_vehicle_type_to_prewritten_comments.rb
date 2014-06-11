class AddVehicleTypeToPrewrittenComments < ActiveRecord::Migration
  def up
    add_column :prewritten_comments, :vehicle_type, :string
  end

  def down
    remove_column :prewritten_comments, :vehicle_type
  end
end
