class AddTransmissionTypes < ActiveRecord::Migration
  def up
    remove_column :versions, :transmission
    add_column :versions, :transmission_numbers, :integer
    add_column :versions, :transmission_type, :string
  end

  def down
    add_column :versions, :transmission, :string
    remove_column :versions, :transmission_numbers
    remove_column :versions, :transmission_type
  end
end
