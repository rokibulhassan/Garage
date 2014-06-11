@javascript
Feature: View performances of vehicle versions
  In order to estimate how good or bad vehicle versions are
  As a guest
  I want to view vehicle version properties

  Scenario Outline: navigation to vehicle specifications tab by direct links
    Given a user "john" exists with username: "johndoe"
    And the following approved versions exist:
      | approved version |
      | audi tt          |
      | bmw x5           |

    And the following version properties exist:
      | version                     | name       | value  | unit_type   |
      | approved version: "audi tt" | <property> | <val1> | <unit_type> |
      | approved version: "bmw x5"  | <property> | <val2> | <unit_type> |

    And the following vehicle with avatars exist:
      | vehicle with avatar | version                     |
      | audi                | approved version: "audi tt" |
      | bmw                 | approved version: "bmw x5"  |

    And the following modifications exists:
      | modification | name     | vehicle                    |
      | mod 1        | test mod | vehicle with avatar "audi" |
      | mod 2        | test mod | vehicle with avatar "bmw"  |

    And the following modification properties exists:
      | modification         | name       | value         |
      | modification "mod 1" | <property> | <mod_val1> |
      | modification "mod 2" | <property> | <mod_val2> |

    And the change set "cs1" exists with name: "Cool CSa", vehicle: vehicle with avatar "audi", modifications:
      | modification         |
      | modification "mod 1" |
    And the change set "cs1" is current for the vehicle with avatar "audi"

    And the change set "cs2" exists with name: "Cool CSb", vehicle: vehicle with avatar "bmw", modifications:
      | modification         |
      | modification "mod 2" |
    And the change set "cs2" is current for the vehicle with avatar "bmw"

    And I login as the user "john"

    When I go to the vehicle with avatar "audi"'s performances by a direct link

    Then I should see "<val_out1>" within ".<klass> .value"
    And I should see "<cur_out1>" within ".<klass> .current"
    And I should see "<gain_out1>" within ".<klass> .gain"
    And I should not see "<val_out2>" within ".<klass> .value"
    And I should not see "<cur_out2>" within ".<klass> .current"
    And I should not see "<gain_out2>" within ".<klass> .gain"

    When I go to the vehicle with avatar "bmw"'s performances by a direct link

    Then I should see "<val_out2>" within ".<klass> .value"
    And I should see "<cur_out2>" within ".<klass> .current"
    And I should see "<gain_out2>" within ".<klass> .gain"
    And I should not see "<val_out1>" within ".<klass> .value"
    And I should not see "<cur_out1>" within ".<klass> .current"
    And I should not see "<gain_out1>" within ".<klass> .gain"

  Examples:
    | property            | klass               | unit_type  | val1 | val_out1  | mod_val1 | cur_out1  | gain_out1 | val2 | val_out2  | mod_val2 | cur_out2  | gain_out2  |
    | top_speed           | top_speed           | speed      | 190  | 190 km/h  | 213      | 213 km/h  | 23 km/h   | 210  | 210 km/h  | 117      | 117 km/h  | -93 km/h   |
    | CO2_emissions       | CO2_emissions       | emissions  | 127  | 127 gr/km | 111      | 111 gr/km | -16 gr/km | 338  | 338 gr/km | 231      | 231 gr/km | -107 gr/km |
    | accel_time_0_60_kph | accel_time_0_60_kph | short_time | 0.1  | 0.1 s     | 0.5      | 0.5 s     | 0.4 s     | 0.4  | 0.4 s     | 1        | 1 s       | 0.6 s      |