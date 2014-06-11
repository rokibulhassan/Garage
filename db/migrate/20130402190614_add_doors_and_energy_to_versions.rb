class AddDoorsAndEnergyToVersions < ActiveRecord::Migration
  def up
    add_column :versions, :doors, :integer
    add_column :versions, :energy, :string
    add_column :versions, :transmission_details, :string
    add_column :versions, :hide_model_name, :boolean
  end

  def down
    remove_column :versions, :doors
    remove_column :versions, :energy
    remove_column :versions, :transmission_details
    remove_column :versions, :hide_model_name
  end
end
