class AddDistanceAndDurationForAccelerationAndBraking < ActiveRecord::Migration
  def up
    rename_column :data_sheets, :acceleration_0_60_mph, :acceleration_0_60_mph_duration
    rename_column :data_sheets, :acceleration_60_130_mph, :acceleration_60_130_mph_duration
    rename_column :data_sheets, :acceleration_0_100_kmh, :acceleration_0_100_kmh_duration
    rename_column :data_sheets, :acceleration_0_160_kmh, :acceleration_0_160_kmh_duration
    rename_column :data_sheets, :acceleration_0_200_kmh, :acceleration_0_200_kmh_duration
    rename_column :data_sheets, :acceleration_0_300_kmh, :acceleration_0_300_kmh_duration
    rename_column :data_sheets, :acceleration_100_200_kmh, :acceleration_100_200_kmh_duration
    rename_column :data_sheets, :acceleration_1_4_mile, :acceleration_1_4_mile_duration
    rename_column :data_sheets, :acceleration_1000_metre, :acceleration_1000_metre_duration
    rename_column :data_sheets, :acceleration_mile, :acceleration_mile_duration
    rename_column :data_sheets, :braking_60_0_mph, :braking_60_0_mph_duration
    rename_column :data_sheets, :braking_100_0_mph, :braking_100_0_mph_duration
    rename_column :data_sheets, :braking_100_0_kmh, :braking_100_0_kmh_duration
    rename_column :data_sheets, :braking_200_0_kmh, :braking_200_0_kmh_duration
    rename_column :data_sheets, :braking_300_0_kmh, :braking_300_0_kmh_duration

    add_column :data_sheets, :acceleration_0_60_mph_distance, :float
    add_column :data_sheets, :acceleration_60_130_mph_distance, :float
    add_column :data_sheets, :acceleration_0_100_kmh_distance, :float
    add_column :data_sheets, :acceleration_0_160_kmh_distance, :float
    add_column :data_sheets, :acceleration_0_200_kmh_distance, :float
    add_column :data_sheets, :acceleration_0_300_kmh_distance, :float
    add_column :data_sheets, :acceleration_100_200_kmh_distance, :float

    add_column :data_sheets, :braking_60_0_mph_distance, :float
    add_column :data_sheets, :braking_100_0_mph_distance, :float
    add_column :data_sheets, :braking_100_0_kmh_distance, :float
    add_column :data_sheets, :braking_200_0_kmh_distance, :float
    add_column :data_sheets, :braking_300_0_kmh_distance, :float
  end

  def down
    rename_column :data_sheets, :acceleration_0_60_mph_duration, :acceleration_0_60_mph
    rename_column :data_sheets, :acceleration_60_130_mph_duration, :acceleration_60_130_mph
    rename_column :data_sheets, :acceleration_0_100_kmh_duration, :acceleration_0_100_kmh
    rename_column :data_sheets, :acceleration_0_160_kmh_duration, :acceleration_0_160_kmh
    rename_column :data_sheets, :acceleration_0_200_kmh_duration, :acceleration_0_200_kmh
    rename_column :data_sheets, :acceleration_0_300_kmh_duration, :acceleration_0_300_kmh
    rename_column :data_sheets, :acceleration_100_200_kmh_duration, :acceleration_100_200_kmh
    rename_column :data_sheets, :acceleration_1_4_mile_duration, :acceleration_1_4_mile
    rename_column :data_sheets, :acceleration_1000_metre_duration, :acceleration_1000_metre
    rename_column :data_sheets, :acceleration_mile_duration, :acceleration_mile
    rename_column :data_sheets, :braking_60_0_mph_duration, :braking_60_0_mph
    rename_column :data_sheets, :braking_100_0_mph_duration, :braking_100_0_mph
    rename_column :data_sheets, :braking_100_0_kmh_duration, :braking_100_0_kmh
    rename_column :data_sheets, :braking_200_0_kmh_duration, :braking_200_0_kmh
    rename_column :data_sheets, :braking_300_0_kmh_duration, :braking_300_0_kmh

    remove_column :data_sheets, :acceleration_0_60_mph_distance
    remove_column :data_sheets, :acceleration_60_130_mph_distance
    remove_column :data_sheets, :acceleration_0_100_kmh_distance
    remove_column :data_sheets, :acceleration_0_160_kmh_distance
    remove_column :data_sheets, :acceleration_0_200_kmh_distance
    remove_column :data_sheets, :acceleration_0_300_kmh_distance
    remove_column :data_sheets, :acceleration_100_200_kmh_distance

    remove_column :data_sheets, :braking_60_0_mph_distance
    remove_column :data_sheets, :braking_100_0_mph_distance
    remove_column :data_sheets, :braking_100_0_kmh_distance
    remove_column :data_sheets, :braking_200_0_kmh_distance
    remove_column :data_sheets, :braking_300_0_kmh_distance
  end
end
