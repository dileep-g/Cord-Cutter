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
    
  Scenario: Show and Edit and Destroy
    When I follow "Device list" 
    Then I should be on the devices page

  Scenario: Add Package
    Given I am on the devices page
    When I follow "New Device"
    Then I should be on the new device page
    And I fill in "Name" with "ABC"
    #And I fill in "Cost" with "10"
    #And I go with "Sun TV, KTV" from Channels
    And I press "Create new device"
    Then I should see "Create success!"
    And I am on the device page