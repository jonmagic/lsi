Feature: Interactively operate on list

  Background:
    Given a file named "file.txt" with "hello world"

  Scenario: Choosing yes
    When I run `lsi cat` interactively
    And I type "y"
    And I close the stdin stream
    Then the exit status should be 0
    And the output should contain:
    """
    Run `cat file.txt`? [y,n,q] (y):
    """
    And the output should contain:
    """
    hello world
    """

  Scenario: Choosing no
    When I run `lsi cat` interactively
    And I type "n"
    And I close the stdin stream
    Then the exit status should be 0
    And the output should contain:
    """
    Run `cat file.txt`? [y,n,q] (y):
    """
    And the output should not contain:
    """
    hello world
    """

  Scenario: Choosing quit
    Given a file named "other.txt" with "foo bar"
    When I run `lsi cat` interactively
    And I type "q"
    Then the exit status should be 0
    And the output should contain:
    """
    Run `cat file.txt`? [y,n,q] (y):
    """
    And the output should not contain:
    """
    Run `cat other.txt`? [y,n,q] (y):
    """
    And the output should not contain:
    """
    hello world
    """
    And the output should not contain:
    """
    foo bar
    """
