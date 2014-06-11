@javascript
Feature: registration
  In order to participate to app and try all it's cool feature
  As a visitor
  I want to register on the site

  Scenario: view profile information
    # FIXME: something is wrong with this step
    Given I am a guest with English language preferred

    When I go to the dashboard page by a direct link

    # FIXME:actually should be
    # And I click on "New member signup"

    And I click on "S'inscrire"
    And I fill in "username" with "blackjack" within the modal
    And I fill in "email" with "blackjack@blackjack.com" within the modal
    And I fill in "password" with "password" within the modal
    And I fill in "password_confirmation" with "password" within the modal
    And I check "terms_of_service" within the modal
    And I press on "register" within the modal

    And I wait for AJAX

    Then I should see "blackjack" within "#top-bar"