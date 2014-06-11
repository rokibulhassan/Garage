@javascript
Feature: View galleries list
  In order to enjoy my vehicle photos
  As a user
  I want to view galleries list for my vehicle

  Scenario: View existing galleries list on the user vehicle page
    Given a user "john" exists with username: "johndoe"
    And the following approved vehicles exist:
      | approved vehicle | user        |
      | my celica        | user "john" |
      | my camry         | user "john" |
    And the following galleries exist:
      | title       | vehicle                      |
      | Celica 2011 | approved vehicle "my celica" |
      | Celica 2012 | approved vehicle "my celica" |
      | Camry Paris | approved vehicle "my camry"  |

    And I login as the user "john"

    When I go to the approved vehicle "my celica"'s my profile
    And I click on "Galleries"

    Then I should see "Celica 2011" within the content
    And I should see "Celica 2012" within the content
    And I should not see "Camry Paris" within the content
