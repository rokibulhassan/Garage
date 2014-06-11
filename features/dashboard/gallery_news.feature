@javascript
Feature: gallery news feature
  In order to watch following users news
  As a user
  I want to see gallery news on dashboard

  Scenario: new gallery news
    Given the following users exists:
      | user | username  | last_name | last_name |
      | john | johndoe   | Doe       | John      |
      | jack | blackjack | Black     | Jack      |

    And the following followings exists:
      | user        | thing       |
      | user "john" | user "jack" |

    And an approved version "daewoo lanos" exists
    And a vehicle with avatar "daewoo" exists with version: approved version "daewoo lanos", user: user "jack"

    When I login as the user "john"

    Then I should not see "blackjack" within "#news"

    When I logout
    And I login as the user "jack"
    And I go to the vehicle with avatar "daewoo"'s profile by a direct link
    And I click on "Galleries"
    And I upload a file using "pictures" input within the vehicle's gallery tab
    And I logout
    And I login as the user "john"

    Then I should see "blackjack created new gallery" within "#news"
    And I should see "#image1.jpg" image within ".gallery-pictures"

  Scenario: gallery picture news
    Given the following users exists:
      | user | username  | last_name | last_name |
      | john | johndoe   | Doe       | John      |
      | jack | blackjack | Black     | Jack      |

    And the following followings exists:
      | user        | thing       |
      | user "john" | user "jack" |

    And an approved vehicle "renault megane" exists with user: user "jack"
    And a gallery "yellow megane" exists with vehicle: approved vehicle "renault megane"

    When I login as the user "john"

    Then I should not see "User blackjack upload new picture" within "#news"

    When I logout
    And I login as the user "jack"
    And I go to the approved vehicle "renault megane"'s profile by a direct link
    And I click on "Galleries"
    And I go to the gallery "yellow megane"'s pictures list
    And I upload a file using "picture[image]" input within the vehicle gallery
    And I logout
    And I login as the user "john"

    Then I should see "#image1.jpg" image

  Scenario: gallery picture comments
    Given the following users exists:
      | user | username  | last_name | last_name |
      | john | johndoe   | Doe       | John      |
      | jack | blackjack | Black     | Jack      |

    And the following followings exists:
      | user        | thing       |
      | user "john" | user "jack" |

    And an approved vehicle "renault megane" exists with user: user "jack"
    And a gallery "yellow megane" exists with vehicle: approved vehicle "renault megane"
    And a picture "my" exists with title: "controversial", gallery: gallery "yellow megane"

    When I login as the user "john"

    Then I should not see "blackjack My comment" within "#news"

    When I logout
    And I login as the user "jack"
    And I go to the approved vehicle "renault megane"'s profile by a direct link
    And I click on "Galleries"
    And I go to the gallery "yellow megane"'s pictures list
    And I click on "controversial" image
    And I fill in "comment" with "My comment" within ".new-comment"
    And I submit a new picture comment
    And I logout
    And I login as the user "john"

    Then I should see "blackjack My comment" within "#news"