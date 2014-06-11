@javascript
Feature: View vehicle avatar
  In order to recognize vehicles by avatar
  As a user
  I want to view vehicle avatar

  Scenario Outline: show avatar only for vehicles with completed data
    Given a user "john" exists with username: "johndoe"

    And the following easy versions exist:
      | easy version | brand_name | model_name | transmission_numbers   | transmission_type   |
      | bmw x7       | Bmw        | X7         | <transmission_numbers> | <transmission_type> |
    And the following vehicles exist:
      | vehicle | user        | version               |
      | bmw x7  | user "john" | easy version "bmw x7" |

    And I login as the user "john"
    When I go to the vehicle "bmw x7"'s profile by a direct link
    Then I <should> see "Bmw X7 picture" image

    Examples:
    | transmission_numbers | transmission_type | should     |
    | 1                    | auto              | should     |
    |                      |                   | should not |