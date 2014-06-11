@javascript
Feature: vehicle comparisons
  In order to determine better vehicle
  As a user
  I want to compare vehicles by their properties

  Scenario Outline: comparing the change sets
    Given a user "john" exists with username: "johndoe"
    And the following easy approved versions exist:
      | easy approved version | brand_name | model_name | name   |
      | audi                  | Audi       | TT         | RS 2.5 |
    And the vehicle "audi tt" exist with user: user "john", version: version "audi"
    And the following modifications exists:
      | modification | vehicle           |
      | mod a1       | vehicle "audi tt" |
      | mod a2       | vehicle "audi tt" |
    And the following version properties exist:
      | version                       | name             | value           | unit_type   |
      | easy approved version: "audi" | <attribute_name> | <stock_value>   | <unit_type> |
    And the following modification properties exists:
      | modification           | name                 | value          |
      | modification "mod a1"  | <attribute_name>     | <value_mod_a1> |
      | modification "mod a2"  | <attribute_name>     | <value_mod_a2> |
    And the change set "Audi CS1" exists with name: "Audi CS1", vehicle: vehicle "audi tt", modifications:
      | modification          |
      | modification "mod a1" |
    And the change set "Audi CS2" exists with name: "Audi CS2", vehicle: vehicle "audi tt", modifications:
      | modification          |
      | modification "mod a2" |
    And the comparison table "CT1" exists with label: "My comparison", user: user "john", vehicles:
      | vehicle           |
      | vehicle "audi tt" |

    And I login as the user "john"
    When I go to the comparison table "CT1" by a direct link
    Then I should see "<value>" within the <attribute_name> change set "<change_set>" comparison attribute
    Then I should see "<unit>" within the <attribute_name> change set "<change_set>" comparison attribute
    And the width of the <attribute_name> change set "<change_set>" comparison attribute bar should be "<bar_width>"

    Examples:
    | value | unit | stock_value | value_mod_a1 | value_mod_a2 | unit_type  | attribute_name       | bar_width  | change_set |
    | 75    | hp   | 100         | -25          | 50           | power      | max_power            | 40%        | Audi CS1   |
    | 195   | s    | 170         | 25           | 15           | short_time | accel_time_0_100_kph | 70%        | Audi CS1   |
    | 105   | km/h | 5           | 50           | 100          | speed      | top_speed            | 80%        | Audi CS2   |

  Scenario Outline: non EU system of units
    Given the following users exist:
      | user       | username    | system_of_units_code   |
      | <user_name>| <user_name> | <system_of_units_code> |
    And an approved version "ford focus" exists
    And the following version properties exist:
      | version                       | name             | value | unit_type        |
      | approved version "ford focus" | consumption_city | 10    | fuel_consumption |
    And a vehicle "ford" exists with version: approved version "ford focus"
    And the following modifications exists:
      | modification | vehicle        |
      | ford mod     | vehicle "ford" |
    And the following modification properties exists:
      | modification            | name             | value |
      | modification "ford mod" | consumption_city | 10    |
    And the change set "Ford CS" exists with name: "Ford CS", vehicle: vehicle "ford", modifications:
      | modification            |
      | modification "ford mod" |
    And the comparison table "CT" exists with label: "My comparison", user: user "<user_name>", vehicles:
      | vehicle        |
      | vehicle "ford" |

    And I login as the user "<user_name>"
    When I go to the comparison table "CT" by a direct link
    And I click on "consumption" within the comparison attributes group navigation
    And I should see "<value>" within the consumption_city change set "Ford CS" comparison attribute
    And I should see "<unit>" within the consumption_city change set "Ford CS" comparison attribute
    And I logout

    Examples:
      | user_name | value | unit      | system_of_units_code |
      | john      | 20    | L/100 km  | EU                   |
      | richard   | 14.12 | mpg (UK)  | UK                   |

  Scenario: saving of selected change sets state
    Given a user "john" exists with username: "johndoe"
    And the following easy approved versions exist:
      | easy approved version | brand_name | model_name | name   |
      | audi                  | Audi       | TT         | RS 2.5 |
    And the vehicle "audi tt" exist with user: user "john", version: version "audi"
    And the following modifications exists:
      | modification | vehicle           |
      | mod a1       | vehicle "audi tt" |
      | mod a2       | vehicle "audi tt" |
    And the following version properties exist:
      | version                       | name      | value | unit_type |
      | easy approved version: "audi" | top_speed | 5     | speed     |
    And the following modification properties exists:
      | modification           | name      | value |
      | modification "mod a1"  | top_speed | 50    |
      | modification "mod a2"  | top_speed | 100   |
    And the change set "Audi CS1" exists with name: "Audi CS1", vehicle: vehicle "audi tt", modifications:
      | modification          |
      | modification "mod a1" |
    And the change set "Audi CS2" exists with name: "Audi CS2", vehicle: vehicle "audi tt", modifications:
      | modification          |
      | modification "mod a2" |
    And the comparison table "CT1" exists with label: "My comparison", user: user "john", vehicles:
      | vehicle           |
      | vehicle "audi tt" |

    And I login as the user "john"
    When I go to the comparison table "CT1" by a direct link
    Then the "Audi CS1" checkbox should be checked
    And the "Audi CS2" checkbox should be checked
    When I uncheck "Audi CS1" within the comparison table change set checkbox
    And I go to the comparison table "CT1" by a direct link
    Then the "Audi CS1" checkbox should not be checked
    And the "Audi CS2" checkbox should be checked

  Scenario: stock configuration should always present in the comparison tables
    Given a user "john" exists with username: "johndoe"
    And the following easy approved versions exist:
      | easy approved version | brand_name | model_name | name   |
      | audi                  | Audi       | TT         | RS 2.5 |
    And the vehicle "audi tt" exist with user: user "john", version: version "audi"
    And the following version properties exist:
      | version                       | name      | value | unit_type |
      | easy approved version: "audi" | top_speed | 500   | speed     |
    And the comparison table "CT1" exists with label: "My comparison", user: user "john", vehicles:
      | vehicle           |
      | vehicle "audi tt" |

    And I login as the user "john"
    When I go to the comparison table "CT1" by a direct link
    Then I should see "Stock" within the comparison table change set checkbox
    And I should see "500" within the top_speed comparison attribute
    And I should see "km/h" within the top_speed comparison attribute

  Scenario: remove vehicle from comparison table
    Given a user "john" exists with username: "johndoe"
    And the following easy approved versions exist:
      | easy approved version | brand_name | model_name | name   |
      | audi                  | Audi       | TT         | RS 2.5 |
    And the vehicle "audi tt" exist with user: user "john", version: easy approved version "audi"
    And the comparison table "CT1" exists with label: "My comparison", user: user "john", vehicles:
      | vehicle           |
      | vehicle "audi tt" |

    And I login as the user "john"
    When I go to the comparison table "CT1" by a direct link
    Then I should see "Audi TT" within the comparison table change set checkbox
    When I click on vehicle "audi tt" remove icon within the comparison table change set checkbox
    Then I should not see "Audi TT" within the comparison table change set checkbox
