Feature: Default list and command

  Scenario: Running lsi without arguments or options
    Given a file named "file.txt" with "hello world"
    When I run `lsi` interactively
    And I type "y"
    And I close the stdin stream
    Then the exit status should be 0
    And the output should contain:
    """
    Get info for `file.txt`? [y,n,q] (y):
    """
    And the output should contain:
    """
    file.txt is a 11 byte file with permissions 100644
    """
