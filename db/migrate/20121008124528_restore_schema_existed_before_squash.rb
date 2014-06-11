class RestoreSchemaExistedBeforeSquash < ActiveRecord::Migration
  def change
    create_table "active_admin_comments", :force => true do |t|
      t.string   "resource_id",   :null => false
      t.string   "resource_type", :null => false
      t.integer  "author_id"
      t.string   "author_type"
      t.text     "body"
      t.datetime "created_at",    :null => false
      t.datetime "updated_at",    :null => false
      t.string   "namespace"
    end

    add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
    add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
    add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_admin_notes_on_resource_type_and_resource_id"

    create_table "activity_events", :force => true do |t|
      t.integer  "actor_id"
      t.string   "type"
      t.integer  "target_id"
      t.string   "target_type"
      t.text     "other_data"
      t.datetime "created_at",  :null => false
      t.datetime "updated_at",  :null => false
    end

    add_index "activity_events", ["actor_id"], :name => "index_activity_events_on_actor_id"
    add_index "activity_events", ["target_id", "target_type"], :name => "index_activity_events_on_target_id_and_target_type"

    create_table "activity_reports", :force => true do |t|
      t.integer  "user_id"
      t.integer  "activity_event_id"
      t.datetime "created_at",        :null => false
      t.datetime "updated_at",        :null => false
    end

    add_index "activity_reports", ["activity_event_id"], :name => "index_activity_reports_on_activity_event_id"
    add_index "activity_reports", ["user_id"], :name => "index_activity_reports_on_user_id"

    create_table "admin_users", :force => true do |t|
      t.string   "email",                  :default => "", :null => false
      t.string   "encrypted_password",     :default => "", :null => false
      t.string   "reset_password_token"
      t.datetime "reset_password_sent_at"
      t.datetime "remember_created_at"
      t.integer  "sign_in_count",          :default => 0
      t.datetime "current_sign_in_at"
      t.datetime "last_sign_in_at"
      t.string   "current_sign_in_ip"
      t.string   "last_sign_in_ip"
      t.datetime "created_at",                             :null => false
      t.datetime "updated_at",                             :null => false
    end

    add_index "admin_users", ["email"], :name => "index_admin_users_on_email", :unique => true
    add_index "admin_users", ["reset_password_token"], :name => "index_admin_users_on_reset_password_token", :unique => true

    create_table "attributes", :force => true do |t|
      t.integer  "vehicle_id"
      t.integer  "field_definition_id"
      t.integer  "static_value_id"
      t.string   "value"
      t.integer  "dynamic_value_id"
      t.integer  "unit_id"
      t.datetime "created_at",          :null => false
      t.datetime "updated_at",          :null => false
      t.string   "dynamic_value_type"
    end

    add_index "attributes", ["field_definition_id"], :name => "index_attributes_on_field_definition_id"
    add_index "attributes", ["vehicle_id"], :name => "index_attributes_on_vehicle_id"

    create_table "brands", :force => true do |t|
      t.string   "name"
      t.string   "label_fr"
      t.string   "label_en"
      t.datetime "created_at",                              :null => false
      t.datetime "updated_at",                              :null => false
      t.boolean  "use_production_codes", :default => false, :null => false
      t.boolean  "open_to_fixes",        :default => false, :null => false
      t.integer  "upvotes_count",        :default => 0
      t.integer  "downvotes_count",      :default => 0
      t.boolean  "pending",              :default => false, :null => false
      t.string   "type_of_business"
      t.boolean  "rejected",             :default => false, :null => false
    end

    create_table "collages", :force => true do |t|
      t.integer  "gallery_id"
      t.datetime "created_at",    :null => false
      t.datetime "updated_at",    :null => false
      t.string   "active_layout"
      t.integer  "position"
      t.integer  "profile_id"
      t.string   "type"
    end

    create_table "comments", :force => true do |t|
      t.integer  "user_id"
      t.integer  "picture_id"
      t.text     "body"
      t.datetime "created_at", :null => false
      t.datetime "updated_at", :null => false
    end

    create_table "comparison_table_vehicles", :force => true do |t|
      t.integer  "comparison_table_id"
      t.integer  "vehicle_id"
      t.text     "properties"
      t.datetime "created_at",          :null => false
      t.datetime "updated_at",          :null => false
      t.integer  "revision_id"
    end

    add_index "comparison_table_vehicles", ["comparison_table_id"], :name => "index_comparison_table_vehicles_on_comparison_table_id"
    add_index "comparison_table_vehicles", ["revision_id"], :name => "index_comparison_table_vehicles_on_revision_id"
    add_index "comparison_table_vehicles", ["vehicle_id"], :name => "index_comparison_table_vehicles_on_vehicle_id"

    create_table "comparison_tables", :force => true do |t|
      t.string   "label"
      t.integer  "user_id"
      t.datetime "created_at", :null => false
      t.datetime "updated_at", :null => false
    end

    add_index "comparison_tables", ["user_id"], :name => "index_comparison_tables_on_user_id"

    create_table "cutouts", :force => true do |t|
      t.integer  "collage_id"
      t.integer  "row"
      t.integer  "col"
      t.string   "image"
      t.text     "crop"
      t.datetime "created_at",                      :null => false
      t.datetime "updated_at",                      :null => false
      t.integer  "picture_id"
      t.string   "layout"
      t.integer  "image_revision",   :default => 1
      t.string   "youtube_video_id"
      t.integer  "youtube_start_at"
      t.boolean  "youtube_hd"
    end

    create_table "data_sheets", :force => true do |t|
      t.integer  "vehicle_id"
      t.integer  "version_id"
      t.string   "fuel_type"
      t.string   "electric_drive"
      t.string   "cycle"
      t.string   "engine_code"
      t.integer  "cylinders_count"
      t.float    "displacement"
      t.float    "bore"
      t.float    "stroke"
      t.float    "compression_ratio"
      t.integer  "valves_count_per_cylinder"
      t.string   "camshaft"
      t.string   "diesel_injection"
      t.string   "fuel_injection"
      t.integer  "throttle_bodies_count"
      t.float    "throttle_body_diameter"
      t.boolean  "carburetor"
      t.integer  "carburetors_count"
      t.float    "carburetor_diameter"
      t.string   "carburetor_brand"
      t.string   "carburetor_cubic_feet_per_minute"
      t.boolean  "reed_valve"
      t.boolean  "rotary_disc"
      t.boolean  "turbocharged"
      t.integer  "turbochargers_count"
      t.boolean  "variable_turbine_geometry"
      t.boolean  "supercharged"
      t.boolean  "intercooler"
      t.string   "ignition_timing"
      t.boolean  "knock_sensor"
      t.integer  "spark_coils_count"
      t.integer  "spark_plugs_count_per_cylinder"
      t.string   "voltage"
      t.float    "battery_capacity"
      t.float    "alternator_power"
      t.boolean  "alternator_energy_saving"
      t.boolean  "start_and_stop"
      t.boolean  "catalysator"
      t.integer  "catalysators_count"
      t.boolean  "oxygen_sensor"
      t.integer  "oxygen_sensors_count"
      t.boolean  "variable_exhaust_system"
      t.boolean  "electric_exhaust_cutout"
      t.boolean  "diesel_particulate_filter"
      t.float    "maximal_power"
      t.integer  "maximal_power_speed"
      t.float    "maximal_torque"
      t.integer  "maximal_torque_speed"
      t.integer  "red_line_speed"
      t.string   "electric_propulsion_system"
      t.integer  "electric_motors_count"
      t.integer  "total_power_output"
      t.string   "battery_technology"
      t.integer  "motor_battery_capacity"
      t.integer  "quick_charge_duration"
      t.integer  "quick_charge_autonomy"
      t.integer  "slow_charge_duration"
      t.integer  "slow_charge_autonomy"
      t.boolean  "capacitor"
      t.string   "kinetic_energy_recovery_system"
      t.string   "transmission"
      t.string   "transmission_type"
      t.string   "coupler"
      t.string   "clutch_actuation"
      t.integer  "gears_count"
      t.float    "gear_1_ratio"
      t.float    "gear_2_ratio"
      t.float    "gear_3_ratio"
      t.float    "gear_4_ratio"
      t.float    "gear_5_ratio"
      t.float    "gear_6_ratio"
      t.float    "gear_7_ratio"
      t.float    "gear_8_ratio"
      t.boolean  "low_range_gears"
      t.string   "differential"
      t.boolean  "electronically_controlled_differential"
      t.boolean  "force_vectoring_system"
      t.float    "final_drive_ratio"
      t.string   "final_drive_type"
      t.float    "pinion_size"
      t.float    "rear_sprocket_size"
      t.string   "shape"
      t.string   "construction"
      t.string   "material"
      t.integer  "doors_count"
      t.integer  "seats_count"
      t.integer  "length"
      t.integer  "width"
      t.integer  "height"
      t.integer  "wheelbase"
      t.integer  "front_track"
      t.integer  "rear_track"
      t.string   "steering_architecture"
      t.float    "steering_turning_circle"
      t.string   "steering_power_assist"
      t.boolean  "steering_variable_assist"
      t.boolean  "steering_variable_ratio"
      t.string   "suspension_front_type"
      t.string   "suspension_front_springs_type"
      t.string   "suspension_front_leaf_type"
      t.string   "suspension_front_dampers"
      t.string   "suspension_front_roll_bars_type"
      t.string   "suspension_rear_type"
      t.string   "suspension_rear_springs_type"
      t.string   "suspension_rear_leaf_type"
      t.string   "suspension_rear_dampers"
      t.string   "suspension_rear_roll_bars_type"
      t.string   "frame_material"
      t.string   "suspension_rear_swing_arm"
      t.string   "suspension_rear_damper"
      t.integer  "seat_height"
      t.boolean  "seat_height_adjustable"
      t.float    "rake_angle"
      t.float    "trail"
      t.float    "ride_height"
      t.string   "brake_front_type"
      t.integer  "brake_front_count"
      t.float    "brake_front_diameter"
      t.string   "brake_front_drum_command"
      t.string   "brake_front_disc_material"
      t.float    "brake_front_disc_thickness"
      t.integer  "brake_front_disc_pistons_count"
      t.string   "brake_rear_type"
      t.integer  "brake_rear_count"
      t.float    "brake_rear_diameter"
      t.string   "brake_rear_drum_command"
      t.string   "brake_rear_disc_material"
      t.float    "brake_rear_disc_thickness"
      t.integer  "brake_rear_disc_pistons_count"
      t.boolean  "abs"
      t.boolean  "stability_control"
      t.string   "wheel_construction"
      t.integer  "rim_bolt_pattern"
      t.float    "rim_bolt_circle"
      t.boolean  "tubeless"
      t.float    "centerbore"
      t.string   "tire_speed_index"
      t.float    "tire_front_width"
      t.float    "tire_front_height"
      t.float    "tire_front_load_index"
      t.float    "rim_front_diameter"
      t.float    "rim_front_width"
      t.float    "rim_front_offset"
      t.float    "tire_rear_width"
      t.float    "tire_rear_height"
      t.float    "tire_rear_load_index"
      t.float    "rim_rear_diameter"
      t.float    "rim_rear_width"
      t.float    "rim_rear_offset"
      t.float    "consumption_city"
      t.float    "consumption_highway"
      t.float    "consumption_combined"
      t.float    "tank_capacity"
      t.float    "emissions_co2"
      t.float    "emissions_nox"
      t.string   "emission_standards"
      t.float    "top_speed"
      t.float    "acceleration_0_60_mph_duration"
      t.float    "acceleration_60_130_mph_duration"
      t.float    "acceleration_0_100_kmh_duration"
      t.float    "acceleration_0_160_kmh_duration"
      t.float    "acceleration_0_200_kmh_duration"
      t.float    "acceleration_0_300_kmh_duration"
      t.float    "acceleration_100_200_kmh_duration"
      t.float    "acceleration_1_4_mile_duration"
      t.float    "acceleration_1_4_mile_speed"
      t.float    "acceleration_1000_metre_duration"
      t.float    "acceleration_1000_metre_speed"
      t.float    "acceleration_mile_duration"
      t.float    "acceleration_mile_speed"
      t.float    "braking_60_0_mph_duration"
      t.float    "braking_100_0_mph_duration"
      t.float    "braking_100_0_kmh_duration"
      t.float    "braking_200_0_kmh_duration"
      t.float    "braking_300_0_kmh_duration"
      t.datetime "created_at",                                                :null => false
      t.datetime "updated_at",                                                :null => false
      t.integer  "model_id"
      t.integer  "production_code_id"
      t.integer  "generation_id"
      t.boolean  "open_to_fixes",                          :default => false, :null => false
      t.float    "acceleration_0_60_mph_distance"
      t.float    "acceleration_60_130_mph_distance"
      t.float    "acceleration_0_100_kmh_distance"
      t.float    "acceleration_0_160_kmh_distance"
      t.float    "acceleration_0_200_kmh_distance"
      t.float    "acceleration_0_300_kmh_distance"
      t.float    "acceleration_100_200_kmh_distance"
      t.float    "braking_60_0_mph_distance"
      t.float    "braking_100_0_mph_distance"
      t.float    "braking_100_0_kmh_distance"
      t.float    "braking_200_0_kmh_distance"
      t.float    "braking_300_0_kmh_distance"
    end

    add_index "data_sheets", ["generation_id"], :name => "index_data_sheets_on_generation_id"
    add_index "data_sheets", ["model_id"], :name => "index_data_sheets_on_model_id"
    add_index "data_sheets", ["production_code_id"], :name => "index_data_sheets_on_production_code_id"
    add_index "data_sheets", ["vehicle_id"], :name => "index_data_sheets_on_vehicle_id"
    add_index "data_sheets", ["version_id"], :name => "index_data_sheets_on_version_id"

    create_table "engines", :force => true do |t|
      t.string   "name"
      t.string   "label_fr"
      t.string   "label_en"
      t.integer  "model_id"
      t.datetime "created_at", :null => false
      t.datetime "updated_at", :null => false
    end

    add_index "engines", ["model_id"], :name => "index_engines_on_model_id"

    create_table "favorites", :force => true do |t|
      t.string   "url"
      t.integer  "user_id"
      t.string   "label"
      t.datetime "created_at",         :null => false
      t.datetime "updated_at",         :null => false
      t.string   "image_file_name"
      t.string   "image_content_type"
      t.integer  "image_file_size"
      t.datetime "image_updated_at"
      t.string   "page_url"
    end

    add_index "favorites", ["user_id"], :name => "index_favorites_on_user_id"

    create_table "field_definitions", :force => true do |t|
      t.string   "name"
      t.string   "label_fr"
      t.string   "label_en"
      t.string   "type"
      t.integer  "fieldset_id"
      t.datetime "created_at",   :null => false
      t.datetime "updated_at",   :null => false
      t.integer  "unit_id"
      t.text     "values"
      t.string   "values_type"
      t.string   "scoped_by"
      t.integer  "unit_type_id"
      t.string   "keyword"
      t.integer  "priority"
    end

    add_index "field_definitions", ["fieldset_id"], :name => "index_vehicle_template_field_definitions_on_fieldset_id"
    add_index "field_definitions", ["unit_id"], :name => "index_vehicle_template_field_definitions_on_unit_id"
    add_index "field_definitions", ["unit_type_id"], :name => "index_field_definitions_on_unit_type_id"

    create_table "fieldsets", :force => true do |t|
      t.string   "name"
      t.datetime "created_at",                :null => false
      t.datetime "updated_at",                :null => false
      t.string   "label_en"
      t.string   "label_fr"
      t.integer  "priority",   :default => 0
    end

    create_table "fixes", :force => true do |t|
      t.string   "fixable_type"
      t.integer  "fixable_id"
      t.string   "attribute_name"
      t.string   "value"
      t.integer  "upvotes_count",   :default => 0
      t.integer  "downvotes_count", :default => 0
      t.integer  "user_id"
      t.datetime "created_at",                         :null => false
      t.datetime "updated_at",                         :null => false
      t.string   "locale"
      t.boolean  "pending",         :default => true,  :null => false
      t.boolean  "rejected",        :default => false, :null => false
      t.datetime "validated_at"
    end

    create_table "followings", :force => true do |t|
      t.string   "thing_type"
      t.integer  "thing_id"
      t.integer  "user_id"
      t.datetime "created_at", :null => false
      t.datetime "updated_at", :null => false
    end

    add_index "followings", ["thing_type", "thing_id"], :name => "index_followings_on_thing_type_and_thing_id"
    add_index "followings", ["user_id"], :name => "index_followings_on_user_id"

    create_table "galleries", :force => true do |t|
      t.string   "title"
      t.integer  "cover_picture_id"
      t.datetime "created_at",                             :null => false
      t.datetime "updated_at",                             :null => false
      t.string   "token"
      t.boolean  "finished",         :default => false,    :null => false
      t.integer  "vehicle_id"
      t.string   "layout",           :default => "grid"
      t.string   "privacy",          :default => "public"
      t.integer  "position"
    end

    add_index "galleries", ["cover_picture_id"], :name => "index_galleries_on_cover_picture_id"

    create_table "generations", :force => true do |t|
      t.integer  "production_code_id"
      t.integer  "first_year"
      t.integer  "last_year"
      t.string   "label_fr"
      t.string   "label_en"
      t.datetime "created_at",         :null => false
      t.datetime "updated_at",         :null => false
    end

    add_index "generations", ["production_code_id"], :name => "index_generations_on_production_code_id"

    create_table "models", :force => true do |t|
      t.string   "name"
      t.string   "label_fr"
      t.string   "label_en"
      t.integer  "brand_id"
      t.datetime "created_at",                         :null => false
      t.datetime "updated_at",                         :null => false
      t.string   "vehicle_type"
      t.boolean  "pending",         :default => true,  :null => false
      t.boolean  "rejected",        :default => false, :null => false
      t.integer  "upvotes_count",   :default => 0,     :null => false
      t.integer  "downvotes_count", :default => 0,     :null => false
    end

    add_index "models", ["brand_id"], :name => "index_models_on_brand_id"

    create_table "modification_changes", :force => true do |t|
      t.integer  "modification_id"
      t.datetime "created_at",           :null => false
      t.datetime "updated_at",           :null => false
      t.string   "type"
      t.integer  "property_instance_id"
    end

    add_index "modification_changes", ["modification_id"], :name => "index_modification_changes_on_modification_id"
    add_index "modification_changes", ["property_instance_id"], :name => "index_modification_changes_on_property_instance_id"

    create_table "modification_parts", :force => true do |t|
      t.integer  "part_id"
      t.integer  "modification_id"
      t.integer  "quantity"
      t.datetime "created_at",                         :null => false
      t.datetime "updated_at",                         :null => false
      t.boolean  "main",            :default => false, :null => false
      t.float    "price"
    end

    add_index "modification_parts", ["modification_id"], :name => "index_modification_parts_on_modification_id"
    add_index "modification_parts", ["part_id"], :name => "index_modification_parts_on_part_id"

    create_table "modification_services", :force => true do |t|
      t.integer  "modification_id"
      t.integer  "service_id"
      t.datetime "created_at",      :null => false
      t.datetime "updated_at",      :null => false
    end

    add_index "modification_services", ["modification_id"], :name => "index_modification_services_on_modification_id"
    add_index "modification_services", ["service_id"], :name => "index_modification_services_on_service_id"

    create_table "modifications", :force => true do |t|
      t.string   "name"
      t.integer  "revision_id"
      t.datetime "created_at",  :null => false
      t.datetime "updated_at",  :null => false
      t.integer  "vehicle_id"
    end

    add_index "modifications", ["revision_id"], :name => "index_modifications_on_revision_id"
    add_index "modifications", ["vehicle_id"], :name => "index_modifications_on_vehicle_id"

    create_table "part_purchases", :force => true do |t|
      t.integer  "vehicle_id"
      t.integer  "vendor_id"
      t.integer  "part_id"
      t.boolean  "special",         :default => false, :null => false
      t.float    "price"
      t.integer  "quantity"
      t.date     "bought_at"
      t.datetime "created_at",                         :null => false
      t.datetime "updated_at",                         :null => false
      t.integer  "modification_id"
    end

    add_index "part_purchases", ["modification_id"], :name => "index_part_purchases_on_modification_id"
    add_index "part_purchases", ["part_id"], :name => "index_part_purchases_on_part_id"
    add_index "part_purchases", ["vendor_id"], :name => "index_part_purchases_on_vendor_id"

    create_table "parts", :force => true do |t|
      t.string   "label_fr"
      t.string   "label_en"
      t.string   "manufacturer_reference"
      t.boolean  "special",                :default => false, :null => false
      t.integer  "category_id"
      t.datetime "created_at",                                :null => false
      t.datetime "updated_at",                                :null => false
      t.integer  "brand_id"
    end

    add_index "parts", ["brand_id"], :name => "index_parts_on_brand_id"
    add_index "parts", ["category_id"], :name => "index_parts_on_category_id"

    create_table "pictures", :force => true do |t|
      t.text     "title"
      t.datetime "created_at",                              :null => false
      t.datetime "updated_at",                              :null => false
      t.integer  "gallery_id"
      t.text     "image_meta"
      t.string   "image"
      t.integer  "image_big_width"
      t.integer  "image_big_height"
      t.integer  "image_rotation",   :default => 0
      t.integer  "image_revision",   :default => 1
      t.text     "image_blur_areas"
      t.integer  "position"
      t.string   "type"
      t.integer  "profile_id"
      t.string   "media_type",       :default => "picture"
      t.string   "video_id"
    end

    add_index "pictures", ["gallery_id"], :name => "index_pictures_on_gallery_id"

    create_table "production_codes", :force => true do |t|
      t.string   "label_fr"
      t.string   "label_en"
      t.integer  "model_id"
      t.datetime "created_at",                         :null => false
      t.datetime "updated_at",                         :null => false
      t.string   "name"
      t.boolean  "pending",         :default => true,  :null => false
      t.boolean  "rejected",        :default => false, :null => false
      t.integer  "upvotes_count",   :default => 0,     :null => false
      t.integer  "downvotes_count", :default => 0,     :null => false
    end

    add_index "production_codes", ["model_id"], :name => "index_production_codes_on_model_id"

    create_table "properties", :force => true do |t|
      t.string   "name"
      t.integer  "position"
      t.integer  "properties_group_id"
      t.datetime "created_at",                             :null => false
      t.datetime "updated_at",                             :null => false
      t.string   "format_string"
      t.boolean  "least_is_best",       :default => false, :null => false
    end

    add_index "properties", ["properties_group_id"], :name => "index_properties_on_properties_group_id"

    create_table "properties_groups", :force => true do |t|
      t.string   "name"
      t.integer  "position"
      t.datetime "created_at",   :null => false
      t.datetime "updated_at",   :null => false
      t.string   "vehicle_type"
    end

    create_table "property_attribute_values", :force => true do |t|
      t.string   "value"
      t.integer  "property_attribute_id"
      t.integer  "property_instance_id"
      t.datetime "created_at",            :null => false
      t.datetime "updated_at",            :null => false
    end

    add_index "property_attribute_values", ["property_attribute_id"], :name => "index_property_attribute_values_on_property_attribute_id"
    add_index "property_attribute_values", ["property_instance_id"], :name => "index_property_attribute_values_on_property_instance_id"

    create_table "property_attributes", :force => true do |t|
      t.string   "name"
      t.string   "type"
      t.integer  "property_id"
      t.datetime "created_at",  :null => false
      t.datetime "updated_at",  :null => false
      t.integer  "position"
      t.text     "values"
    end

    add_index "property_attributes", ["property_id"], :name => "index_property_attributes_on_property_id"

    create_table "property_instances", :force => true do |t|
      t.integer  "property_id"
      t.integer  "resource_with_property_id"
      t.string   "resource_with_property_type"
      t.datetime "created_at",                  :null => false
      t.datetime "updated_at",                  :null => false
    end

    add_index "property_instances", ["resource_with_property_id", "resource_with_property_type"], :name => "index_property_instances_on_resource_with_property"

    create_table "property_suggestions", :force => true do |t|
      t.integer  "version_id"
      t.integer  "property_instance_id"
      t.integer  "upvotes_count"
      t.datetime "created_at",           :null => false
      t.datetime "updated_at",           :null => false
      t.integer  "property_id"
    end

    add_index "property_suggestions", ["property_id"], :name => "index_property_suggestions_on_property_id"
    add_index "property_suggestions", ["property_instance_id"], :name => "index_property_suggestions_on_property_instance_id"
    add_index "property_suggestions", ["version_id"], :name => "index_property_suggestions_on_version_id"

    create_table "revisions", :force => true do |t|
      t.integer  "vehicle_id"
      t.integer  "index"
      t.date     "date"
      t.datetime "created_at",                    :null => false
      t.datetime "updated_at",                    :null => false
      t.string   "label"
      t.boolean  "default",    :default => false, :null => false
    end

    add_index "revisions", ["vehicle_id"], :name => "index_revisions_on_vehicle_id"

    create_table "services", :force => true do |t|
      t.string   "label"
      t.integer  "vendor_id"
      t.string   "service_type"
      t.float    "price"
      t.date     "done_at"
      t.string   "duration_type"
      t.datetime "created_at",    :null => false
      t.datetime "updated_at",    :null => false
      t.integer  "vehicle_id"
    end

    add_index "services", ["vehicle_id"], :name => "index_services_on_vehicle_id"
    add_index "services", ["vendor_id"], :name => "index_services_on_vendor_id"

    create_table "side_views", :force => true do |t|
      t.string   "image"
      t.datetime "created_at", :null => false
      t.datetime "updated_at", :null => false
    end

    create_table "static_values", :force => true do |t|
      t.string   "label_fr"
      t.string   "label_en"
      t.integer  "field_definition_id"
      t.datetime "created_at",          :null => false
      t.datetime "updated_at",          :null => false
      t.string   "name"
    end

    add_index "static_values", ["field_definition_id"], :name => "index_static_values_on_field_definition_id"

    create_table "supplier_references", :force => true do |t|
      t.string   "name"
      t.string   "reference"
      t.boolean  "obsolete"
      t.integer  "part_id"
      t.datetime "created_at", :null => false
      t.datetime "updated_at", :null => false
    end

    add_index "supplier_references", ["part_id"], :name => "index_supplier_references_on_part_id"

    create_table "unit_systems", :force => true do |t|
      t.string   "label_fr"
      t.string   "label_en"
      t.string   "name"
      t.datetime "created_at", :null => false
      t.datetime "updated_at", :null => false
    end

    create_table "unit_type_belongings", :force => true do |t|
      t.integer  "unit_system_id"
      t.integer  "unit_type_id"
      t.integer  "unit_id"
      t.datetime "created_at",     :null => false
      t.datetime "updated_at",     :null => false
    end

    add_index "unit_type_belongings", ["unit_id"], :name => "index_unit_type_belongings_on_unit_id"
    add_index "unit_type_belongings", ["unit_system_id"], :name => "index_unit_type_belongings_on_unit_system_id"
    add_index "unit_type_belongings", ["unit_type_id"], :name => "index_unit_type_belongings_on_unit_type_id"

    create_table "unit_types", :force => true do |t|
      t.string   "label_fr"
      t.string   "label_en"
      t.string   "name"
      t.datetime "created_at", :null => false
      t.datetime "updated_at", :null => false
    end

    create_table "units", :force => true do |t|
      t.string   "label_fr"
      t.string   "label_en"
      t.integer  "unit_type_id"
      t.datetime "created_at",   :null => false
      t.datetime "updated_at",   :null => false
      t.string   "name"
    end

    add_index "units", ["unit_type_id"], :name => "index_units_on_unit_type_id"

    create_table "user_oppositions", :force => true do |t|
      t.integer  "user_id"
      t.integer  "opposer_id"
      t.datetime "created_at", :null => false
      t.datetime "updated_at", :null => false
    end

    add_index "user_oppositions", ["user_id", "opposer_id"], :name => "by_user_and_opposer", :unique => true

    create_table "users", :force => true do |t|
      t.string   "username"
      t.string   "email"
      t.string   "password_digest"
      t.string   "persistence_token"
      t.string   "country_code"
      t.string   "city"
      t.datetime "created_at",                                  :null => false
      t.datetime "updated_at",                                  :null => false
      t.string   "facebook_access_token"
      t.string   "locale"
      t.string   "language_code"
      t.boolean  "confirmed",                :default => false, :null => false
      t.datetime "confirmed_at"
      t.string   "confirmation_token"
      t.datetime "confirmation_received_at"
      t.string   "first_name"
      t.string   "last_name"
      t.string   "gender"
      t.string   "facebook_id"
      t.string   "password_recovery_token"
      t.boolean  "newbie",                   :default => true,  :null => false
      t.boolean  "first_name_public",        :default => false, :null => false
      t.boolean  "last_name_public",         :default => false, :null => false
      t.boolean  "emailing_allowed",         :default => false, :null => false
      t.string   "currency"
      t.boolean  "city_public",              :default => false, :null => false
      t.string   "avatar_file_name"
      t.string   "avatar_content_type"
      t.integer  "avatar_file_size"
      t.datetime "avatar_updated_at"
      t.string   "system_of_units_code"
    end

    create_table "vehicle_bookmarks", :force => true do |t|
      t.integer  "user_id"
      t.integer  "vehicle_id"
      t.datetime "created_at", :null => false
      t.datetime "updated_at", :null => false
    end

    add_index "vehicle_bookmarks", ["user_id", "vehicle_id"], :name => "by_user_and_vehicle", :unique => true

    create_table "vehicle_figures", :force => true do |t|
      t.string   "label"
      t.string   "url"
      t.integer  "model_id"
      t.datetime "created_at", :null => false
      t.datetime "updated_at", :null => false
      t.integer  "width"
      t.integer  "height"
    end

    add_index "vehicle_figures", ["model_id"], :name => "index_vehicle_figures_on_model_id"

    create_table "vehicle_templates", :force => true do |t|
      t.string   "name"
      t.datetime "created_at", :null => false
      t.datetime "updated_at", :null => false
      t.string   "title"
    end

    create_table "vehicles", :force => true do |t|
      t.integer  "user_id"
      t.datetime "created_at",                        :null => false
      t.datetime "updated_at",                        :null => false
      t.string   "vehicle_type"
      t.string   "main_user"
      t.datetime "ownership_begin_at"
      t.datetime "ownership_ended_at"
      t.string   "avatar_file_name"
      t.string   "avatar_content_type"
      t.integer  "avatar_file_size"
      t.datetime "avatar_updated_at"
      t.integer  "brand_id"
      t.integer  "model_id"
      t.string   "avatar"
      t.string   "mosaic_style",        :limit => 50
      t.integer  "doors_count"
      t.string   "body"
      t.integer  "version_id"
      t.integer  "year"
      t.string   "fuel_type"
      t.string   "gear_box"
      t.integer  "engine_id"
      t.integer  "side_view_id"
    end

    add_index "vehicles", ["brand_id"], :name => "index_vehicles_on_brand_id"
    add_index "vehicles", ["engine_id"], :name => "index_vehicles_on_engine_id"
    add_index "vehicles", ["model_id"], :name => "index_vehicles_on_model_id"
    add_index "vehicles", ["user_id"], :name => "index_vehicles_on_user_id"
    add_index "vehicles", ["version_id"], :name => "index_vehicles_on_version_id"

    create_table "vendors", :force => true do |t|
      t.string   "name"
      t.string   "website"
      t.string   "street"
      t.string   "zipcode"
      t.string   "city"
      t.string   "country_code"
      t.datetime "created_at",   :null => false
      t.datetime "updated_at",   :null => false
    end

    create_table "version_vehicle_figures", :force => true do |t|
      t.integer  "version_id"
      t.integer  "vehicle_figure_id"
      t.datetime "created_at",        :null => false
      t.datetime "updated_at",        :null => false
    end

    add_index "version_vehicle_figures", ["vehicle_figure_id"], :name => "index_version_vehicle_figures_on_vehicle_figure_id"
    add_index "version_vehicle_figures", ["version_id"], :name => "index_version_vehicle_figures_on_version_id"

    create_table "versions", :force => true do |t|
      t.string   "name"
      t.string   "label_fr"
      t.string   "label_en"
      t.integer  "model_id"
      t.datetime "created_at",                            :null => false
      t.datetime "updated_at",                            :null => false
      t.integer  "production_code_id"
      t.integer  "vehicle_figure_id"
      t.boolean  "pending",            :default => true,  :null => false
      t.boolean  "rejected",           :default => false, :null => false
      t.integer  "upvotes_count",      :default => 0,     :null => false
      t.integer  "downvotes_count",    :default => 0,     :null => false
    end

    add_index "versions", ["model_id"], :name => "index_versions_on_model_id"
    add_index "versions", ["production_code_id"], :name => "index_versions_on_production_code_id"
    add_index "versions", ["vehicle_figure_id"], :name => "index_versions_on_vehicle_figure_id"

    create_table "votes", :force => true do |t|
      t.integer  "fixable_id"
      t.integer  "user_id"
      t.string   "value"
      t.datetime "created_at",   :null => false
      t.datetime "updated_at",   :null => false
      t.string   "fixable_type"
    end
  end
end
