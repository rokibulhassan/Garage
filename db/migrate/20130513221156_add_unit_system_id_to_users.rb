class AddUnitSystemIdToUsers < ActiveRecord::Migration
  def up
    add_column :users, :unit_system_id, :integer

    User.reset_column_information

    labels = %w(EU UK US)
    labels.each do |label|
      instance_variable_set("@#{label}", BaseUnitSystem.where(:label => label).first)
    end
    User.all.each do |user|
      label = user.system_of_units_code
      user.unit_system = instance_variable_get("@#{label}")
      user.save!
    end
  end

  def down
    remove_column :users, :unit_system_id
  end
end
