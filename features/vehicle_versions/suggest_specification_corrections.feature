@javascript
Feature: Suggest specification corrections
  In order to fix missing or wrong specification values
  As a user
  I want to suggest specification corrections

  Scenario: suggest missing values, with conversion of units
    Given the following users exist:
      | user    | username   | system_of_units_code |
      | john    | johndoe    | UK                   |
      | richard | richardroe | EU                   |
    And an approved version "daewoo lanos" exists
    And a vehicle with avatar "daewoo" exists with version: approved version "daewoo lanos"
    And the following property definitions exist:
      | name      | unit_type |
      | cylinders | unitless  |
      | length    | length    |
    And the following version properties exist:
      | name  | value | unit_type | version                         |
      | width | 1230  | length    | approved version "daewoo lanos" |
    And I login as the user "john"

    When I go to the vehicle with avatar "daewoo"'s specifications by a direct link

    Then I should see "Cylinders n/a" within the content
    And I should see "Length n/a" within the content

    When I click on "Suggest corrections" within the content
    And I fill in "cylinders" with "4" within the content
    And I fill in "length" with "3785" within the content
    And I click on "Back to view" within the content

    Then I should see "Cylinders 4" within the content
    And I should see "Length 3785 mm" within the content

    When I logout
    And I login as the user "richard"
    And I go to the vehicle with avatar "daewoo"'s specifications by a direct link

    Then I should see "Cylinders 4" within the content
    And I should see "Length 3785 mm" within the content

  Scenario: suggest corrections
    Given the following users exist:
      | user    | username   | system_of_units_code |
      | john    | johndoe    | UK                   |
      | richard | richardroe | EU                   |
    And an approved version "daewoo lanos" exists
    And a vehicle with avatar "daewoo" exists with version: approved version "daewoo lanos"
    And the following version properties exist:
      | name  | value | unit_type | version                         |
      | width | 1230  | length    | approved version "daewoo lanos" |
    And I login as the user "john"

    When I go to the vehicle with avatar "daewoo"'s specifications by a direct link

    Then I should see "Width 1230" within the content

    When I click on "Suggest corrections" within the content
    And I fill in "width" with "1250" within the content
    And I click on "Back to view" within the content

    Then I should see "Width 1230" within the content

    When I logout
    And I login as the user "richard"
    And I go to the vehicle with avatar "daewoo"'s specifications by a direct link
    And I click on "Suggest corrections" within the content
    And I fill in "width" with "1250" within the content
    And I click on "Back to view" within the content

    Then I should see "Width 1250" within the content

  Scenario: edit property specs
    Given the following users exist:
      | user    | username   | system_of_units_code |
      | john    | johndoe    | UK                   |
    And an version "daewoo lanos" exists
    And a vehicle with avatar "daewoo" exists with version: version "daewoo lanos", user: user "john"
    And the following version properties exist:
      | name  | value | unit_type | version                |
      | width | 1230  | length    | version "daewoo lanos" |
    And I login as the user "john"

    When I go to the vehicle with avatar "daewoo"'s specifications by a direct link

    Then I should see "Width 1230" within the content

    When I click on "Edit specs" within the content
    And I fill in "width" with "1250" within the content
    And I click on "Back to view" within the content

    Then I should see "Width 1250" within the content