@javascript
Feature: Delete picture comments
  In order to remove spammy/insulting comments from my gallery pictures
  As a user
  I want to delete picture comments

  Scenario Outline:
    Given a user "john" exists with username: "johndoe"
    And a user "richard" exists with username: "richardroe"
    And an approved vehicle "<vehicle>" exists with user: user "<owner>"
    And the following galleries exist:
      | gallery   | vehicle             |
      | <gallery> | vehicle "<vehicle>" |
    And the following pictures exist:
      | picture   | title            | gallery              |
      | <picture> | <picture_title>  | gallery: "<gallery>" |
    And the following comments exist:
      | body      | user                | picture              |
      | <comment> | user: "<commentor>" | picture: "<picture>" |

    And I login as the user "john"

    When I go to the vehicle "<vehicle>"'s profile by a direct link
    And I click on "Galleries"
    And I go to the gallery "<gallery>"'s pictures list
    And I click on "<picture_title>" image
    Then I should see "<comment>" within the picture comments list
    And I should <can delete> to delete the first picture comment within the picture comments list
    And I should <can see after> "<comment>" within the picture comments list

    Examples:
      | vehicle | owner   | gallery | picture | picture_title      | comment           | commentor | can delete  | can see after |
      | my      | john    | my      | my      | my - self comment  | me comments me    | john      | be able     | not see       |
      | my      | john    | my      | my      | my - other comment | other comments me | richard   | be able     | not see       |
      | other   | richard | other   | other   | other - my comment | me comments other | john      | not be able | see           |
      | other   | richard | other   | other   | other - comment    | other comments    | richard   | not be able | see           |
