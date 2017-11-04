# Created by yann.piquet at 04/11/2017
Feature: Basic routes are set
  As any user
  I want to check that basic generated routes exists

  Scenario: Index route does not exists
    Given i am not logged in
    When i prepare a request to /
      And i send the request using GET
    Then the return code is 404

  Scenario: Api route exists
    Given i am not logged in
    When i prepare a request to /api/1.0/
      And i send the request using GET
    Then the return code is 200
