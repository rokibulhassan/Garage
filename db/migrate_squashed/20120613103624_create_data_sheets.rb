class CreateDataSheets < ActiveRecord::Migration
  def change
    create_table :data_sheets do |t|
      t.references :vehicle
      t.references :version
      t.string :fuel_type
      t.string :electric_drive
      t.string :cycle
      t.string :engine_code
      t.integer :cylinders_count
      t.float :displacement
      t.float :bore
      t.float :stroke
      t.float :compression_ratio
      t.integer :valves_count_per_cylinder
      t.string :camshaft

      t.string :diesel_injection
      t.string :fuel_injection
      t.integer :throttle_bodies_count
      t.float :throttle_body_diameter

      t.boolean :carburetor
      t.integer :carburetors_count
      t.float :carburetor_diameter
      t.string :carburetor_brand
      t.string :carburetor_cubic_feet_per_minute

      t.boolean :reed_valve
      t.boolean :rotary_disc

      t.boolean :turbocharged
      t.integer :turbochargers_count
      t.boolean :variable_turbine_geometry
      t.boolean :supercharged
      t.boolean :intercooler

      t.string :ignition_timing
      t.boolean :knock_sensor
      t.integer :spark_coils_count
      t.integer :spark_plugs_count_per_cylinder

      t.string :voltage
      t.float :battery_capacity
      t.float :alternator_power
      t.boolean :alternator_energy_saving
      t.boolean :start_and_stop

      t.boolean :catalysator
      t.integer :catalysators_count
      t.boolean :oxygen_sensor
      t.integer :oxygen_sensors_count
      t.boolean :variable_exhaust_system
      t.boolean :electric_exhaust_cutout
      t.boolean :diesel_particulate_filter

      t.float :maximal_power
      t.integer :maximal_power_speed
      t.float :maximal_torque
      t.integer :maximal_torque_speed
      t.integer :red_line_speed

      t.string :electric_propulsion_system
      t.integer :electric_motors_count
      t.integer :total_power_output
      t.string :battery_technology
      t.integer :motor_battery_capacity
      t.integer :quick_charge_duration
      t.integer :quick_charge_autonomy
      t.integer :slow_charge_duration
      t.integer :slow_charge_autonomy

      t.boolean :capacitor
      t.string :kinetic_energy_recovery_system

      t.string :transmission
      t.string :transmission_type
      t.string :coupler
      t.string :clutch_actuation
      t.integer :gears_count
      t.float :gear_1_ratio
      t.float :gear_2_ratio
      t.float :gear_3_ratio
      t.float :gear_4_ratio
      t.float :gear_5_ratio
      t.float :gear_6_ratio
      t.float :gear_7_ratio
      t.float :gear_8_ratio
      t.boolean :low_range_gears

      t.string :differential
      t.boolean :electronically_controlled_differential
      t.boolean :force_vectoring_system
      t.float :final_drive_ratio
      t.string :final_drive_type
      t.float :pinion_size
      t.float :rear_sprocket_size

      t.string :shape
      t.string :construction
      t.string :material
      t.integer :doors_count
      t.integer :seats_count
      t.integer :length
      t.integer :width
      t.integer :height
      t.integer :wheelbase
      t.integer :front_track
      t.integer :rear_track

      t.string :steering_architecture
      t.float :steering_turning_circle
      t.string :steering_power_assist
      t.boolean :steering_variable_assist
      t.boolean :steering_variable_ratio

      t.string :suspension_front_type
      t.string :suspension_front_springs_type
      t.string :suspension_front_leaf_type
      t.string :suspension_front_dampers
      t.string :suspension_front_roll_bars_type

      t.string :suspension_rear_type
      t.string :suspension_rear_springs_type
      t.string :suspension_rear_leaf_type
      t.string :suspension_rear_dampers
      t.string :suspension_rear_roll_bars_type

      t.string :frame_material
      t.string :suspension_rear_swing_arm
      t.string :suspension_rear_damper
      t.integer :seat_height
      t.boolean :seat_height_adjustable

      t.float :rake_angle
      t.float :trail
      t.float :ride_height

      t.string :brake_front_type
      t.integer :brake_front_count
      t.float :brake_front_diameter
      t.string :brake_front_drum_command
      t.string :brake_front_disc_material
      t.float :brake_front_disc_thickness
      t.integer :brake_front_disc_pistons_count

      t.string :brake_rear_type
      t.integer :brake_rear_count
      t.float :brake_rear_diameter
      t.string :brake_rear_drum_command
      t.string :brake_rear_disc_material
      t.float :brake_rear_disc_thickness
      t.integer :brake_rear_disc_pistons_count

      t.boolean :abs
      t.boolean :stability_control

      t.string :wheel_construction
      t.integer :rim_bolt_pattern
      t.float :rim_bolt_circle
      t.boolean :tubeless
      t.float :centerbore
      t.float :tire_speed_index

      t.float :tire_front_width
      t.float :tire_front_height
      t.float :tire_front_load_index
      t.float :rim_front_diameter
      t.float :rim_front_width
      t.float :rim_front_offset

      t.float :tire_rear_width
      t.float :tire_rear_height
      t.float :tire_rear_load_index
      t.float :rim_rear_diameter
      t.float :rim_rear_width
      t.float :rim_rear_offset

      t.float :consumption_city
      t.float :construction_highway
      t.float :construction_combined
      t.float :tank_capacity

      t.float :emissions_co2
      t.float :emissions_nox
      t.string :emission_standards

      t.float :top_speed

      t.float :acceleration_0_60_mph
      t.float :acceleration_60_130_mph
      t.float :acceleration_0_100_kmh
      t.float :acceleration_0_160_kmh
      t.float :acceleration_0_200_kmh
      t.float :acceleration_0_300_kmh
      t.float :acceleration_100_200_kmh

      t.float :acceleration_1_4_mile
      t.float :acceleration_1_4_mile_speed
      t.float :acceleration_1000_metre
      t.float :acceleration_1000_metre_speed
      t.float :acceleration_mile
      t.float :acceleration_mile_speed

      t.float :braking_60_0_mph
      t.float :braking_100_0_mph
      t.float :braking_100_0_kmh
      t.float :braking_200_0_kmh
      t.float :braking_300_0_kmh

      t.timestamps
    end
    add_index :data_sheets, :vehicle_id
    add_index :data_sheets, :version_id
  end
end
