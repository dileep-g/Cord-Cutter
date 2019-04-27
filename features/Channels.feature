Feature: Admin Channels
  
  As an admin
  I want to handle channels
  So that users have a lot of popular choices
  
# Background: Admin is logged in and goes to Channels page
#   Given I am on the login page
#   # And I follow "Sign in with Google"
#   And I follow "View Channels"
#   Then I am on the channels page
Background: Admin is logged in and goes to Channels page
  Given I am on the login page
  And I follow "Log in"
  Then I am on the home page
  
  
  Given the following channels exist:
  | name        |
  | Sun TV      |

  Given the following packages exist:
  | name        | cost |
  | Sun Network |  50  |

Scenario: Show and Edit and Destroy
    Given I am on the signup page
    When I fill in "Email" with "test@test.com"
    And I fill in "Password" with "test123pass"
    And I fill in "Confirmation" with "test123pass"
    And I check "Sign up as admin"
    And I press "Create my account"
    Then I should be on the user page
    And I should see "Sign up success!" 
    Given I am on the login page
    When I fill in "Email" with "test@test.com"
    And I fill in "Password" with "test123pass"
    And I press "Login"
    Then I should be on the user page
    When I follow "Channel list" 
    Then I should be on the channels page
    Then I follow "Show"
    Then I should be on the channels1 page
    And I follow "Edit"
    Then I should be on the edit channels page
    Then I should see "Edit channel"
    Then I fill in "Name" with "ESPN"
    Then I press "Update channel information"
    Then I should see "Update success!"
    Given I am on the edit channels page
    And I follow "Cancel and return to channel information"
    Then I should be on the channels1 page
  

  
# Scenario: Edit Channel
#   When I am on the channel details page for "Sun TV"
#   And I follow "Edit"
#   And I follow "Show"
#   And I follow "Back"
#   Then I should be on the channels page
  
Scenario: Add new Channel
  Given I am on the signup page
    When I fill in "Email" with "test@test.com"
    And I fill in "Password" with "test123pass"
    And I fill in "Confirmation" with "test123pass"
    And I check "Sign up as admin"
    And I press "Create my account"
    Then I should be on the user page
    And I should see "Sign up success!" 
    Given I am on the login page
    When I fill in "Email" with "test@test.com"
    And I fill in "Password" with "test123pass"
    And I press "Login"
    Then I should be on the user page
    When I follow "Channel list" 
    Then I should be on the channels page
  When I am on the channels page
  When follow "New Channel"
  And I fill in "Name" with "Jaya TV"
  And I press "Create new channel"
  Then I should see "Create success!"