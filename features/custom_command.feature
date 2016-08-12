Feature: Custom command

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
