@javascript
Feature: Edit picture comments
  In order to replace my old opinion on vehicle pictures with new one
  As a user
  I want to edit picture comments

  Scenario Outline:
    Given a user "john" exists with username: "johndoe"
    And a user "richard" exists with username: "richardroe"
    And an approved vehicle "renault megane" exists with user: user "john"
    And a gallery "yellow" exists with vehicle: approved vehicle "renault megane"
    And a picture "my" exists with title: "controversial", gallery: gallery "yellow"
    And the following comments exist:
      | body      | user                | picture       | human_created_at |
      | <comment> | user: "<commentor>" | picture: "my" | <created_at>     |

    And I login as the user "john"
    And I go to the approved vehicle "renault megane"'s profile by a direct link
    And I click on "Galleries"
    And I go to the gallery "yellow"'s pictures list

    When I click on "controversial" image
    Then I should see "<comment>" within the picture comments list
    And I should <can edit> to update the first picture comment with "me edits now" within the picture comments list
    And I should see "<comment_after>" within the picture comments list

    Examples:
      | comment              | commentor | created_at | can edit    | comment_after        |
      | other comments       | richard   | now        | not be able | other comments       |
      | me comments now      | john      | now        | be able     | me edits now         |
      | me comments long ago | john      | 8 days ago | not be able | me comments long ago |
