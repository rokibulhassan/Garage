@javascript
Feature: imported content
  In order to make site more attractive
  As a user
  I want to have imported content tab within Albums menu

  Scenario: user should see all imported pictures
    Given the following users exists:
      | user | username  | last_name | last_name |
      | john | johndoe   | Doe       | John      |
      | jack | blackjack | Black     | Jack      |

    And the following profile pictures exists:
      | title        | profile     |
      | john picture | user "john" |
      | jack picture | user "jack" |

    When I login as user "john"
    And I go to the imported content page by a direct link

    Then I should see "john picture" image
    And I should not see "jack picture" image

  Scenario: load more pictures
    Given the following users exists:
      | user | username  | last_name | last_name |
      | john | johndoe   | Doe       | John      |

    And the following profile pictures exists:
      | title         | profile     |
      | john picture1 | user "john" |
      | john picture2 | user "john" |

    And albums per page limit is 1

    When I login as user "john"
    And I go to the imported content page by a direct link

    Then I should see "john picture2" image
    And I should not see "john picture1" image

    When I click on "Load more"
    Then I should see "john picture1" image
