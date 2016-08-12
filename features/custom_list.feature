Feature: Custom list

  Background:
    Given a file named "file.txt" with "one.txt\ntwo.txt three.txt"
    And a file named "one.txt" with "number 1"
    And a file named "two.txt" with "#2"

  Scenario: Choosing yes
    When I run `lsi -l 'cat file.txt'` interactively
    And I type "y"
    And I type "n"
    And I close the stdin stream
    Then the exit status should be 0
    And the output should contain:
    """
    Get info for `one.txt`? [y,n,q] (y):
    """
    And the output should contain:
    """
    one.txt is a 8 byte file with permissions 100644
    """
    And the output should contain:
    """
    Get info for `two.txt three.txt`? [y,n,q] (y):
    """
