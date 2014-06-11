@javascript
Feature: Add modification properties
  In order to compare modified vehicles
  As a user
  I want to add relative changes of version properties to vehicle modifications

  Scenario: conversion of units when user with non-EU system of units enters values
    Given the following users exist:
      | user    | username   | system_of_units_code |
      | john    | johndoe    | UK                   |
      | jane    | janedoe    | UK                   |
      | richard | richardroe | EU                   |
    And the following easy approved versions exist:
      | easy approved version | brand_name | model_name | name   |
      | audi                  | Audi       | TT         | RS 2.5 |
    And the following vehicles exist:
      | vehicle | user        | version        |
      | audi tt | user "john" | version "audi" |
    And the following version properties exist:
      | version                       | name             | value | unit_type        |
      | easy approved version: "audi" | consumption_city | 14.12 | fuel_consumption |
    And the following part modifications exists:
      | name         | vehicle           |
      | eco good mod | vehicle "audi tt" |
      | eco bad mod  | vehicle "audi tt" |

    And I login as the user "john"

    When I go to the vehicle "audi tt"'s profile by a direct link
    And I click on "Modifications"
    And I click on "eco good mod"
    And I click on "Add a change"
    And I select "Consumption city" property name within the modification changes
    And I fill in "consumption_city" with "10" within the modification changes

    And I click on "eco bad mod"
    And I click on "Add a change"
    And I select "Consumption city" property name within the modification changes
    And I fill in "consumption_city" with "-10" within the modification changes

    When I logout
    And I login as the user "jane"
    And I go to the vehicle "audi tt"'s profile by a direct link
    And I click on "Modifications"
    And I click on "eco good mod"
    Then I should see "Consumption city 10 mpg (UK)" within the modification changes
    When I click on "eco bad mod"
    Then I should see "Consumption city -10 mpg (UK)" within the modification changes

    When I logout
    And I login as the user "richard"
    And I go to the vehicle "audi tt"'s profile by a direct link
    And I click on "Modifications"
    And I click on "eco good mod"
    Then I should see "Consumption city -4.71 L/100 km" within the modification changes
    When I click on "eco bad mod"
    Then I should see "Consumption city 14.11 L/100 km" within the modification changes

  Scenario: add values separated by comma
    Given the following users exist:
      | user    | username   |
      | john    | johndoe    |
    And the following easy approved versions exist:
      | easy approved version | brand_name | model_name | name   |
      | audi                  | Audi       | TT         | RS 2.5 |
    And the following vehicles exist:
      | vehicle | user        | version        |
      | audi tt | user "john" | version "audi" |
    And the following version properties exist:
      | version                  | name             | value | unit_type        |
      | easy approved version: "audi" | consumption_city | 14.12 | fuel_consumption |
    And the following part modifications exists:
      | name         | vehicle           |
      | eco good mod | vehicle "audi tt" |

    And I login as the user "john"

    When I go to the vehicle "audi tt"'s profile by a direct link
    And I click on "Modifications"
    And I click on "eco good mod"
    And I click on "Add a change"
    And I select "Consumption city" property name within the modification changes
    And I fill in "consumption_city" with "10,57" within the modification changes

    And I go to the vehicle "audi tt"'s profile by a direct link
    And I click on "Modifications"
    And I click on "eco good mod"

    Then I should see "10.57" in "consumption_city" field