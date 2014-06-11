@javascript
Feature: Delete a vehicle
  In order to cleanup a list of my vehicles from ones I don't like
  As a user
  I want to delete my vehicles

  Scenario: user deletes his own vehicle, no dependants
    Given a user "john" exists with username: "johndoe"
    And the following easy approved vehicles exist:
      | easy approved vehicle | brand_name | model_name | user        |
      | renault               | Renault    | Megane     | user "john" |
      | lexus                 | Lexus      | ES         | user "john" |

    And I login as the user "john"

    When I go to the my profile vehicles via menus

    Then I should see "Renault Megane" within the vehicles tab
    And I should see "Lexus ES" within the vehicles tab

    When I click on "Renault Megane" within the vehicles tab
    And I wait for AJAX
    And the css selector ".delete-vehicle" should exist within the content
    And I click on "delete" within the content
    And I click on "OK" within the bootbox modal

    Then I should not see "Renault Megane" within the vehicles tab
    And I should see "Lexus ES" within the vehicles tab

  Scenario: user doesn't delete other user's vehicle
    Given a user "john" exists with username: "johndoe"
    And a user "richard" exists with username: "richardroe"
    And the following easy approved vehicles exist:
      | easy approved vehicle | brand_name | model_name | user           |
      | daewoo                | Daewoo     | Lanos      | user "richard" |

    And I login as the user "john"

    When I go to the vehicle "daewoo"'s profile by a direct link

    Then I should see "richardroe >Garage >Cars >Daewoo Lanos" within the breadcrumb
    And the css selector ".delete-vehicle" should not exist within the content

  Scenario: user doesn't delete his own vehicle, with dependants
    Given a user "john" exists with username: "johndoe"
    And the following easy approved vehicles exist:
      | easy approved vehicle | brand_name | model_name | user        |
      | renault               | Renault    | Megane     | user "john" |
    And the following galleries exist:
      | vehicle                          |
      | easy approved vehicle: "renault" |

    And I login as the user "john"

    When I go to the my profile vehicles via menus
    Then I should see "Renault Megane" within the vehicles tab

    When I click on "Renault Megane" within the vehicles tab
    And I wait for AJAX
    And I click on "delete" within the content
    And I click on "OK" within the bootbox modal
    And I go to the my profile vehicles via menus
    Then I should see "Renault Megane" within the vehicles tab
