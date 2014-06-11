@javascript
Feature: breadcrumb
  In order to easy navigate on the site
  As a user
  I want to have breadcrumb

  Scenario Outline: visitor views another user vehicles
    Given a user "john" exists with username: "johndoe"
    And a user "richard" exists with username: "richardroe"
    And the following easy approved vehicles exist:
    | easy approved vehicle | user           | brand_name | model_name | vehicle_type |
    | vh                    | user "richard" | <brand>    | <model>    | <type>       |

    And I login as the user "john"

    When I go to the vehicle "vh"'s profile by a direct link

    Then I should see "<label>" within the breadcrumb

    Examples:
    | type       | brand  | model | label                                  |
    | automobile | Daewoo | Lanos | richardroe >Garage >Cars >Daewoo Lanos |
    | motorcycle | Bmw    | X5    | richardroe >Garage >Bikes >Bmw X5      |