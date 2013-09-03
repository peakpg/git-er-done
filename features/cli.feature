Feature: CLI

  In order to make doing the right thing easier in Git
  As a programmer with a bad memory
  I should be able to use a commandline tool to simplify my interface.

  Scenario: Show the Version of the Gem
    When I run `gd version`
    Then the output should contain "Git-Er-Done"
    And should display the current version

  Scenario: Show version using -v
    When I run `gd -v`
    Then the output should contain "Git-Er-Done"
    And should display the current version

  Scenario: Start a New Feature
    Given I am working on a git project
    When I run `gd feature new_widget`
    Then the output should contain "Switched to a new branch 'features/new_widget'"

  Scenario: Sync a Branch
    Given I am working on a git project
    And I am working on the "features/new_widget" branch
    When I run `gd sync`
    Then the output should contain "Switched to branch 'master'"
    And the output should contain "Switched to branch 'features/new_widget"
    And the output should contain "Current branch features/new_widget is up to date"

  Scenario: Inception of a branch
    Given I am working on a git project
    And I run `git checkout -b staging`
    And I commit a new file
    When I run `gd feature new_widget`
    And I commit another file
    And I run `gd inception`
    Then the output should contain:
    """
    Current branch 'features/new_widget' was forked from 'staging'
    """

  Scenario: Ambiguous inception of a branch
    Given I am working on a git project
    And I run `git checkout -b staging`
    When I run `gd feature new_widget`
    And I commit a new file
    And I run `gd inception`
    Then the output should contain:
    """
    Current branch 'features/new_widget' matches the following branches: 'master, staging'
    """

  Scenario: Completing work branched from a non-master branch
    Given I am working on a git project
    And I have been working in the "staging" branch
    When I run `gd feature new_widget`
    And I commit a new file
    And I run `gd done`
    Then the output should contain:
    """
    Switched to branch 'staging'
    """


  
