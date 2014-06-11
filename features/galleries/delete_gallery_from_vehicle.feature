@javascript
Feature: Delete a gallery from its vehicle
  In order to cleanup my vehicle profile from boring galleries
  As a user
  I want to delete galleries from vehicles

  Scenario:
    Given a user "john" exists with username: "johndoe"
    And an approved vehicle "peugeot 3008" exists with user: user "john"
    And the following galleries exist:
      | gallery | title         | vehicle                          |
      | 2010    | 2010 boring   | approved vehicle: "peugeot 3008" |
      | 2012    | 2012 exciting | approved vehicle: "peugeot 3008" |

    And I login as the user "john"
    And I go to the approved vehicle "peugeot 3008"'s my profile
    And I click on "Galleries"

    Then I should see "2010 boring" within the vehicle's gallery tab
    And I should see "2012 exciting" within the vehicle's gallery tab

    When I go to the gallery "2010"'s pictures list
    And I click on "Delete gallery"
    And I click on "OK" within the bootbox modal
    And I click on "Galleries"
    Then I should not see "2010 boring" within the vehicle's gallery tab
    And I should see "2012 exciting" within the vehicle's gallery tab
