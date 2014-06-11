@javascript
Feature: View gallery pictures list
  In order to enjoy my vehicle photos
  As a user
  I want to view gallery pictures list for my vehicle

  Background: I am on the galleries tab of the user vehicle page
    Given a user "john" exists with username: "johndoe"
    And an approved vehicle "bmw x7" exists with user: user "john"
    And the following galleries exist:
      | gallery | title       | vehicle                   |
      | 2011    | My BMW 2011 | approved vehicle "bmw x7" |
      | 2012    | My BMW 2012 | approved vehicle "bmw x7" |
    And the following pictures exist:
      | title            | gallery        |
      | front view pic   | gallery "2011" |
      | rear view pic    | gallery "2011" |
      | in my garage pic | gallery "2012" |

    And I login as the user "john"
    And I go to the approved vehicle "bmw x7"'s my profile
    And I click on "Galleries"

  Scenario: View existing gallery pictures list
    When I click on "2011" within the content
    Then I should see "front view pic" image within the content
    And I should see "rear view pic" image within the content
    And I should not see "in my garage pic" image within the content

  Scenario: Go back to galleries list from gallery pictures list
    When I click on "2011" within the content
    Then I should see "Galleries" within the breadcrumb
    When I click on "Galleries" within the breadcrumb
    Then I should not see "front view pic" image within the content
    And I should see "My BMW 2011" within the content
    And I should see "My BMW 2012" within the content
