@javascript
Feature: View vehicle side views
  In order to recognize vehicles by side views
  As an admin
  I want to view vehicle side views

Background:
  Given an admin user "john" exists
  And the following easy approved versions exist:
    | easy approved version | label | brand_name | model_name | body  |
    | BMW                   | B7    | BMW        | Alpina     | sedan |
    | Audi                  | 2.0   | Audi       | A3         | wagon |

  And I login as the admin user "john" to admin

Scenario: view side views
  Given the following uploaded side views exist:
    | uploaded side view | file_name | version                     |
    | bmw view           | test1.jpg | easy approved version "BMW" |
  When I click on "Side Views"
  Then I should see side view "bmw view"'s image within the admin side views table
  And I should see "Bmw Alpina B7" within the admin side views table
  And I should not see "Audi A3 2.0" within the admin side views table

Scenario: add new side view
  When I click on "Side Views"
  And I click on "New Side View"
  And I select "Audi A3 wagon" side view version from chosen within the admin new side view form
  And I upload a file using "side_view[image]" input within the admin new side view form
  And I click on "Create Side view"
  And I should see "Audi A3 2.0" within the admin side views table
  And I should not see "Bmw Alpina B7" within the admin side views table
