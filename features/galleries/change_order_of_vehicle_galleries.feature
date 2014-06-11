@javascript
Feature: Change order of vehicle galleries
  In order to fix inappropriate order of vehicle galleries
  As a user
  I want to change order of vehicle galleries

  Scenario:
    Given a user "john" exists with username: "johndoe"
    And a user "richard" exists with username: "richardroe"
    And an approved vehicle "john's celica" exists with user: user "john"
    And the following galleries exist:
      | gallery | title | vehicle                           |
      | aa2010  | 2010  | approved vehicle: "john's celica" |
      | bb2011  | 2011  | approved vehicle: "john's celica" |
      | cc2012  | 2012  | approved vehicle: "john's celica" |

    And I login as the user "richard"

    When I go to the approved vehicle "john's celica"'s profile by a direct link
    And I click on "Galleries"
    Then I should see the following thumbnails list:
      | thumbnail         |
      | gallery: "cc2012" |
      | gallery: "bb2011" |
      | gallery: "aa2010" |

    When I logout
    And I login as the user "john"
    And I go to the approved vehicle "john's celica"'s profile by a direct link
    And I click on "Galleries"
    And I drag gallery "cc2012"'s thumbnail to gallery "aa2010"'s thumbnail
    Then I should see the following thumbnails list:
      | thumbnail         |
      | gallery: "bb2011" |
      | gallery: "cc2012" |
      | gallery: "aa2010" |

    When I logout
    And I login as the user "richard"
    And I go to the approved vehicle "john's celica"'s profile by a direct link
    And I click on "Galleries"
    Then I should see the following thumbnails list:
      | thumbnail         |
      | gallery: "bb2011" |
      | gallery: "cc2012" |
      | gallery: "aa2010" |
