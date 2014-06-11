@javascript
Feature: tabs feature
  In order to main user's interest in app
  As a user
  I want to be able to tabs according to state of my vehicle

  Background:
    Given the following users exist:
      | user    | username   |
      | john    | johndoe    |

  Scenario: just created vehicle
    Given the following vehicles exist:
      | vehicle | user        |
      | bmw x7  | user "john" |

    And I login as the user "john"
    When I go to the vehicle "bmw x7"'s profile by a direct link

    Then the "Identification" tab should be available
    And the "Galleries" tab should not be available
    And the "Specifications" tab should not be available
    And the "Modifications" tab should not be available
    And the "Expenses" tab should not be available

  Scenario: vehicle with identification data and picture
    Given the following easy versions exist:
      | easy version | brand_name | model_name | transmission_numbers | transmission_type |
      | bmw x7       | Bmw        | X7         | 1                    | auto              |
    And the following vehicles exist:
      | vehicle | user        | version               |
      | bmw x7  | user "john" | easy version "bmw x7" |
    And I login as the user "john"
    When I go to the vehicle "bmw x7"'s profile by a direct link
    And I upload a file using "avatar" input

    Then the "Specifications" tab should be available
