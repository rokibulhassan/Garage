# encoding: utf-8
# Even though we're using factory girl to populate the db, this is NOT only for Rails.env.test?
#
# This task must be run before we can start editing a vehicles' specifications.
namespace :populate do
  desc 'Populate property definitions'
  task property_definitions: [ :environment ] do
      # property name              | EU unit   | unit type       |
    [
      [ 'cylinders',                   'count', :unitless         ],
      [ 'displacement',                'cm^3',  :small_volume     ],
      [ 'max_power',                   'hp-eu', :power            ],
      [ 'max_power_frequency',         'rpm',   :angular_velocity ],
      [ 'max_torque',                  'N*m',   :energy           ],
      [ 'max_torque_frequency',        'rpm',   :angular_velocity ],
      [ 'weight',                      'kg',    :weight           ],
      [ 'length',                      'mm',    :length           ],
      [ 'width',                       'mm',    :length           ],
      [ 'height',                      'mm',    :length           ],
      [ 'top_speed',                   'km/h',  :speed            ],

      [ 'max_speed_on_402',            'km/h',  :speed            ],
      [ 'max_speed_on_1000',           'km/h',  :speed            ],
      [ 'max_speed_on_1609',           'km/h',  :speed            ],

      [ 'time_on_402',                 's',     :short_time       ],
      [ 'time_on_1000',                's',     :short_time       ],
      [ 'time_on_1609',                's',     :short_time       ],

      [ 'accel_time_0_60_kph',         's',     :short_time       ],
      [ 'accel_time_0_100_kph',        's',     :short_time       ],
      [ 'accel_time_0_160_kph',        's',     :short_time       ],
      [ 'accel_time_0_200_kph',        's',     :short_time       ],
      [ 'accel_time_0_300_kph',        's',     :short_time       ],
      [ 'accel_time_100_200_kph',      's',     :short_time       ],
      [ 'accel_time_200_300_kph',      's',     :short_time       ],
      [ 'accel_time_0_96_kph',         's',     :short_time       ],
      [ 'accel_time_96_209_kph',       's',     :short_time       ],

      [ 'decel_time_100_0_kph',        's',     :short_time       ],
      [ 'decel_time_113_0_kph',        's',     :short_time       ],
      [ 'decel_time_200_0_kph',        's',     :short_time       ],

      [ 'accel_distance_0_60_kph',     'm',     :short_distance   ],
      [ 'accel_distance_0_100_kph',    'm',     :short_distance   ],
      [ 'accel_distance_0_160_kph',    'm',     :short_distance   ],
      [ 'accel_distance_0_200_kph',    'm',     :short_distance   ],
      [ 'accel_distance_0_300_kph',    'm',     :short_distance   ],
      [ 'accel_distance_100_200_kph',  'm',     :short_distance   ],
      [ 'accel_distance_200_300_kph', 'm',     :short_distance   ],
      [ 'accel_distance_0_96_kph',     'm',     :short_distance   ],
      [ 'accel_distance_96_209_kph',   'm',     :short_distance   ],

      [ 'decel_distance_100_0_kph',    'm',     :short_distance   ],
      [ 'decel_distance_113_0_kph',    'm',     :short_distance   ],
      [ 'decel_distance_200_0_kph',    'm',     :short_distance   ],

      [ 'consumption_city',            'fuel',  :fuel_consumption ],
      [ 'consumption_highway',         'fuel',  :fuel_consumption ],
      [ 'consumption_mixed',           'fuel',  :fuel_consumption ],

      [ 'CO2_emissions',               'g/km',  :emissions        ]
    ].each do |definition|
      FactoryGirl.create(:property_definition, name: definition[0], unit_type: definition[2]) unless PropertyDefinition.find_by_name(definition[0])
    end
  end
end
