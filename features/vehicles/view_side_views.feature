@javascript
Feature: View vehicle side views
  In order to recognize vehicles by side views
  As a user
  I want to view vehicle side views

Scenario:
  Given a user "john" exists with username: "johndoe"
  And the following approved versions exist:
    | approved version |
    | bmw              |
    | audi             |
  And the following uploaded side views exist:
    | uploaded side view | file_name | version                 |
    | bmw view           | test1.jpg | approved version "bmw"  |
    | audi view          | test2.jpg | approved version "audi" |
  And the following vehicles exist:
    | vehicle | user        | side_view             | version                 |
    | bmw x7  | user "john" | side view "bmw view"  | approved version "bmw"  |
    | audi tt | user "john" | side view "audi view" | approved version "audi" |

  And I login as the user "john"

  When I go to the vehicle "bmw x7"'s profile by a direct link
  Then I should see side view "bmw view"'s image
  Then I should not see side view "audi view"'s image

Scenario: silhouettes for unapproved vehicles
  Given a user "john" exists with username: "johndoe"
  And the following versions exist:
    | version |
    | bmw     |
  And the following uploaded side views exist:
    | uploaded side view | file_name | version       |
    | bmw view           | test1.jpg | version "bmw" |
  And the following vehicles exist:
    | vehicle | user        | side_view             | version       |
    | bmw x7  | user "john" | side view "bmw view"  | version "bmw" |

  And I login as the user "john"
  When I go to the vehicle "bmw x7"'s profile by a direct link
  Then I should not see side view "bmw view"'s image