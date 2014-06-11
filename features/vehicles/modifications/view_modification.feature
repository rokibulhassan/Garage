@javascript
Feature: View vehicle modifications
  In order to compare vehicles
  As a user
  I want to view modifications

  Background:
    Given the following users exist:
      | user    | username   | system_of_units_code |
      | john    | johndoe    | EU                   |
      | richard | richardroe | US                   |
    And the following easy approved versions exist:
      | easy approved version | brand_name | model_name | name   |
      | audi                  | Audi       | TT         | RS 2.5 |
    And the following vehicles exist:
      | vehicle | user        | version                      |
      | audi tt | user "john" | easy approved version "audi" |

    And the following part modifications exists:
      | part modification | name        | vehicle           | part    | quantity | price |
      | mod 1             | spoiler mod | vehicle "audi tt" | spoiler | 17       | 1383  |
    And the following service modifications exists:
      | service modification | name     | vehicle           | service           | duration | garage      |
      | mod 2                | My mod 2 | vehicle "audi tt" | part_installation | 3        | Bob cleaner |

    And the following modification properties exists:
      | modification property | modification         | name              | unit_type        | value |
      | displacement          | modification "mod 1" | displacement      | small_volume     | 1997  |
      | consumption_city      | modification "mod 1" | consumption_city  | fuel_consumption | 13.8  |
      | top_speed             | modification "mod 2" | top_speed         | speed            | 188   |
      | consumption_mixed     | modification "mod 2" | consumption_mixed | fuel_consumption | 19.2  |

    And I login as the user "john"

  Scenario: correct grouping of part purchases/services/changes
    When I go to the vehicle "audi tt"'s profile by a direct link
    And I click on "Modifications"
    And I click on "spoiler mod"
    Then I should see "spoiler" within the modification parts
    And I should not see "Bob cleaner" within the modification services
    And I should see "Displacement" within the modification changes
    And I should see "Consumption city" within the modification changes
    And I should not see "Top speed" within the modification changes
    And I should not see "Consumption mixed" within the modification changes

    When I click on "mod 2"
    Then I should see "Bob cleaner" within the modification services
    And I should not see "spoiler" within the modification parts
    And I should see "Top speed" within the modification changes
    And I should see "Consumption mixed" within the modification changes
    And I should not see "Displacement" within the modification changes
    And I should not see "Consumption city" within the modification changes

  Scenario: conversion of units
    When I go to the vehicle "audi tt"'s profile by a direct link
    And I click on "Modifications"
    And I click on "spoiler mod"
    Then I should see "Displacement cm3" within the modification changes
    And I should see "1997" in "displacement" field within the modification changes

    When I logout
    And I login as the user "richard"
    And I go to the vehicle "audi tt"'s profile by a direct link
    And I click on "Modifications"
    And I click on "spoiler mod"

    Then I should see "Displacement 121.86 cu in" within the modification changes
