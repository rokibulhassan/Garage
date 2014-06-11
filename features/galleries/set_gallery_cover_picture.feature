@javascript
Feature: Set gallery cover picture
  In order to attract attention to my vehicle's galleries
  As a user
  I want to choose what picture will be a cover for gallery

  Scenario:
    Given a user "john" exists with username: "johndoe"
    And an approved vehicle "vw golf" exists with user: user "john"
    And a gallery "das auto" exists with vehicle: vehicle "vw golf"
    And the following pictures exist:
      | title     | gallery            | covered_gallery    |
      | old cover | gallery "das auto" | gallery "das auto" |
      | new cover | gallery "das auto" |                    |

    And I login as the user "john"
    And I go to the approved vehicle "vw golf"'s my profile
    And I click on "Galleries"

    Then I should see "old cover" image within the content
    And I should not see "new cover" image within the content

    When I go to the gallery "das auto"'s pictures list
    And I click on "new cover" image
    Then I should see "Set as cover"

    When I click on "Set as cover"
    And I go to the approved vehicle "vw golf"'s profile by a direct link
    And I click on "Galleries"
    Then I should not see "old cover" image within the content
    And I should see "new cover" image within the content
