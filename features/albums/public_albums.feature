@javascript
Feature: public albums
  In order to have fun and enjoy
  As a user
  I want to see latest created public albums

  Scenario: public albums
    Given a user "john" exists with username: "johndoe"
    And a user "richard" exists with username: "richardroe"
    And an approved vehicle "john's celica" exists with user: user "john"
    And an approved vehicle "richard's bmw" exists with user: user "richard"

    And the following galleries exist:
      | gallery | title | vehicle                           |
      | aa      | 2010  | approved vehicle: "john's celica" |
      | bb      | 2011  | approved vehicle: "richard's bmw" |

    And the following albums exists:
      | album | title | privacy | user           |
      | cc    | 2012  | public  | user "john"    |
      | dd    | 2012  | public  | user "richard" |
      | ee    | 2012  | private | user "john"    |
      | ff    | 2012  | private | user "richard" |

    When I go to the albums page by a direct link

    Then I should see album "cc" thumbnail
     And I should see album "dd" thumbnail

     And I should not see album "ee" thumbnail
     And I should not see album "ff" thumbnail
     And I should not see gallery "aa" thumbnail
     And I should not see gallery "bb" thumbnail


  Scenario: breadcrumbs
    Given a user "john" exists with username: "johndoe"
    And the following albums exists:
      | album | title | privacy | user           |
      | cc    | 2012  | public  | user "john"    |

    When I go to the albums page by a direct link
     And I click on "2012"

    Then I should see "Albums >johndoe >2012" within the breadcrumb