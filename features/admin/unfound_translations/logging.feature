@javascript
Feature: view unfound translation
  In order to translate users input
  As an admin
  I want to manage untranslated values


Scenario Outline: view unfound translations
  Given an admin user "john" exists
  And the following users exist:
    | user    | username   | locale            |
    | john    | johndoe    | <native_locale>   |
    | jack    | jackdoe    | <watching_locale> |
  And the following approved versions exists:
    | approved version | body  | name  | production_year | transmission_numbers | <attribute> |
    | audi             | tbody | tname | 1999            | 4_auto               | <value>     |
  And the vehicle "audi A6" exist with version: approved version "audi", user: user "john"

  And I login as the user "jack"

  When I go to the vehicle "audi A6"'s profile by a direct link
  And I click on "Identification"

  Then I should see "<value>" within "td.<attribute>"

  When I logout
  And I login as the admin user "john" to admin
  When I click on "Unfound Translations"
  Then I should see "car -> model -> <attribute> -> <value>" within "#model_version_<attribute>_<value>"
  And I should see "<watching_locale>" within "#model_version_<attribute>_<value>"

  Examples:
  | attribute            | native_locale | value  | watching_locale |
  | body                 | en            | sedan  | fr              |
  | transmission_numbers | en            | 5_auto | fr              |
  | transmission_type    | en            | FWD    | fr              |


Scenario:  translate unfound translations
  Given an admin user "john" exists
  And the following unfound translations exist:
    | locale | key                         |
    | en     | model\|version\|body\|sedan |

  And I login as the admin user "john" to admin
  And I click on "Unfound Translations"
  And I click on "car -> model -> body -> sedan"

  And I fill in "Text" with "SomeTranslation"
  And I click on "Create Translation text"

  Then I should see "car -> model -> body -> sedan"
  And I should see "SomeTranslation"

  When I click on "Unfound Translations"

  Then the css selector "#model_version_body_sedan" should not exist