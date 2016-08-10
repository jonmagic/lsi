Feature: Documentation
  In order to use lsi
  I want to have help documentation
  So I can learn the arguments and options

  Scenario: App has help documentation
    When I get help for "lsi"
    Then the exit status should be 0
    And the banner should be present
    And the banner should document that this app takes options
    And the following options should be documented:
      |--version|
    And the banner should document that this app's arguments are:
      | command | which is required |
      | path    | which is optional |
