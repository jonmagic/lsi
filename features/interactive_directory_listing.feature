Feature: Interactively run command on directory listing

  Scenario: Choosing yes
    Given a file named "file.txt" with "hello world"
    When I run `lsi cat` interactively
    And I type "y"
    And I close the stdin stream
    Then the output should contain:
    """
    Run `cat file.txt`? [y,n,q] (y):
    """
    And the output should contain:
    """
    hello world
    """

  Scenario: Choosing no
    Given a file named "file.txt" with "hello world"
    When I run `lsi cat` interactively
    And I type "n"
    And I close the stdin stream
    Then the output should contain:
    """
    Run `cat file.txt`? [y,n,q] (y):
    """
    And the output should not contain:
    """
    hello world
    """
