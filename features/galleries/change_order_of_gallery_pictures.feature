@javascript
Feature: Change order of gallery pictures
  In order to fix inappropriate order of gallery pictures
  As a user
  I want to change order of gallery pictures

  Scenario:
    Given a user "john" exists with username: "johndoe"
    And a user "richard" exists with username: "richardroe"
    And an approved vehicle "john's celica" exists with user: user "john"
    And a gallery "full of pictures" exists with layout: "grid", vehicle: approved vehicle "john's celica"
    And the following pictures exist:
      | picture | gallery                     |
      | aa2010  | gallery: "full of pictures" |
      | bb2011  | gallery: "full of pictures" |
      | cc2012  | gallery: "full of pictures" |

    And I login as the user "richard"

    When I go to the approved vehicle "john's celica"'s profile by a direct link
    And I click on "Galleries"
    And I go to the gallery "full of pictures"'s pictures list
    Then I should see the following thumbnails list:
      | thumbnail         |
      | picture: "cc2012" |
      | picture: "bb2011" |
      | picture: "aa2010" |

    When I logout
    And I login as the user "john"
    And I go to the approved vehicle "john's celica"'s profile by a direct link
    And I click on "Galleries"
    And I go to the gallery "full of pictures"'s pictures list
    And I drag picture "cc2012"'s thumbnail to picture "aa2010"'s thumbnail
    Then I should see the following thumbnails list:
      | thumbnail         |
      | picture: "bb2011" |
      | picture: "cc2012" |
      | picture: "aa2010" |

    When I logout
    And I login as the user "richard"
    And I go to the approved vehicle "john's celica"'s profile by a direct link
    And I click on "Galleries"
    And I go to the gallery "full of pictures"'s pictures list
    Then I should see the following thumbnails list:
      | thumbnail         |
      | picture: "bb2011" |
      | picture: "cc2012" |
      | picture: "aa2010" |
