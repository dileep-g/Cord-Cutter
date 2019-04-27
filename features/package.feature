Feature: Admin Powers
  
  As an admin
  I want to handle stream packages
  So that users have a lot of popular choices
  
# Background: Admin is logged in
#   Given I am on the signin page
#   And I follow "Sign in with Google"
#   Then I am on the home page
Background: Admin is logged in
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
Given the following channels exist:
    | name        |  
    | CBS         | 
    | BET         | 
    | BTN         |
    | A&E         |
    | ABC         |
    | AMC         |
    
  Scenario: Show and Edit and Destroy
    When I follow "Package list" 
    Then I follow "New Package"
    Then I fill in "Name" with "CBS"
    Then I fill in "Cost" with "60"
    And I fill in "Link" with "https://www.Youtube.com"
    Then I check "DVR" 
    Then I check "CBS"
    Then I check "BET"
    Then I check "BTN"
    Then I press "Submit"
    Then I should see "Create success!"
    