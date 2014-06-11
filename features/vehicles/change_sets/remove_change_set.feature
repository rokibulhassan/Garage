@javascript
Feature: remove change set
  In order to clean modification tab view
  As a user
  I want to remove change set

  Background:
    Given a user "john" exists with username: "johndoe"
    And the following approved vehicles exist:
      | approved vehicle | user        |
      | audi tt          | user "john" |
    And the change set exists with name: "Cool CS", vehicle: approved vehicle "audi tt"

  Scenario: change set deleting
    And I login as the user "john"
    When I go to the vehicle "audi tt"'s profile by a direct link
    And I click on "Modifications"
    And I click on "Cool CS"
    And I click on "Delete" within the modifications dashboard

    Then I should not see "Cool CS" within the modifications dashboard

  Scenario: only the owner is able to delete change set
    Given a user "bill" exists with username: "billdoe"
    And I login as the user "bill"
    When I go to the vehicle "audi tt"'s profile by a direct link
    And I click on "Modifications"
    And I click on "Cool CS"
    Then I should not see "Delete" within the modifications dashboard
