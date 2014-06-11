@javascript
Feature: View specifications of vehicle versions
  In order to estimate how good or bad vehicle versions are
  As a guest
  I want to view vehicle version properties

  Scenario: navigation to vehicle specifications tab by direct links
    Given a user "john" exists with username: "johndoe"
    And the following approved versions exist:
      | approved version |
      | audi tt          |
      | bmw x5           |
    And the following property definitions exist:
      | name   | unit_type |
      | weight | weight    |
    And the following version properties exist:
      | version                     | name      | value | unit_type |
      | approved version: "audi tt" | max_power | 190   | power     |
      | approved version: "bmw x5"  | max_power | 210   | power     |
      | approved version: "audi tt" | length    | 4000  | length    |
    And the following vehicle with avatars exist:
      | vehicle with avatar | version                     |
      | audi                | approved version: "audi tt" |
      | bmw                 | approved version: "bmw x5"  |

    And I login as the user "john"

    When I go to the vehicle with avatar "audi"'s specifications by a direct link

    Then I should see "Maximum power 190 hp" within the content
    And I should not see "Maximum power 210 hp" within the content
    And I should see "Length 4000 mm" within the content
    And I should not see "Length n/a" within the content
    And I should see "Weight n/a" within the content

    When I go to the vehicle with avatar "bmw"'s specifications by a direct link

    Then I should see "Maximum power 210 hp" within the content
    And I should see "Length n/a" within the content
    And I should see "Weight n/a" within the content

  Scenario: conversion of units
    Given the following users exist:
      | user    | username   | system_of_units_code |
      | john    | johndoe    | EU                   |
      | richard | richardroe | UK                   |
    And an approved version "ford focus" exists
    And the following version properties exist:
      | version                       | name      | value | unit_type |
      | approved version "ford focus" | cylinders | 4     | unitless  |
      | approved version "ford focus" | weight    | 1318  | weight    |
    And a vehicle with avatar "ford" exists with version: approved version "ford focus"

    And I login as the user "john"

    When I go to the vehicle with avatar "ford"'s specifications by a direct link
    And accordion components are all visible

    Then I should see "Cylinders 4" within the content
    And I should see "Weight 1318 kg" within the content
    When I logout

    And I login as the user "richard"

    When I go to the vehicle with avatar "ford"'s specifications by a direct link
    And accordion components are all visible

    Then I should see "Cylinders 4" within the content
    And I should see "Weight 2905.69 lb" within the content
