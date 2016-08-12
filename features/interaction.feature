Feature: Interactively operate on list

  Background:
    Given a file named "file.txt" with "hello world"

  Scenario: Choosing yes
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

  Scenario: Choosing no
    When I run `lsi` interactively
    And I type "n"
    And I close the stdin stream
    Then the exit status should be 0
    And the output should contain:
    """
    Get info for `file.txt`? [y,n,q] (y):
    """
    And the output should not contain:
    """
    file.txt is a 11 byte file with permissions 100644
    """

  Scenario: Choosing quit
    Given a file named "other.txt" with "foo bar"
    When I run `lsi` interactively
    And I type "q"
    Then the exit status should be 0
    And the output should contain:
    """
    Get info for `file.txt`? [y,n,q] (y):
    """
    And the output should not contain:
    """
    file.txt is a 11 byte file with permissions 100644
    """
    And the output should not contain:
    """
    Get info for `other.txt`? [y,n,q] (y):
    """
