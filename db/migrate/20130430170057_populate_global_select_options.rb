class PopulateGlobalSelectOptions < ActiveRecord::Migration
  def up
    vehicle_types = Vehicle::TYPES
    global_select_option_names = %w(body energy doors transmission_numbers transmission_type transmission_details)
    vehicle_types.each do |vehicle_type|
      global_select_option_names.each do |option_name|
        GlobalSelectOption.where(:vehicle_type => vehicle_type, :name => option_name).first_or_create
      end
    end
  end

  def down
  end
end
