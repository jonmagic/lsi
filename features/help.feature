Feature: Help documentation

  Scenario: I run lsi -h
    When I run `lsi -h`
    Then the exit status should be 0
    And the banner should be present
    And the banner should document that this app takes options
    And the following options should be documented:
      |--version|
    And the banner should document that this app's arguments are:
      | command | which is optional |
      | path    | which is optional |
