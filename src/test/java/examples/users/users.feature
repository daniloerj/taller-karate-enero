@users
Feature: sample karate test script
  for help, see: https://github.com/karatelabs/karate/wiki/IDE-Support

  Background:
    * url baseUrl
    * print 'Running tests in environment:', ambiente

  @getUsers @smoke @regression @positive
  Scenario: get all users and then get the first user by id
    Given path 'users',4
    When method get
    Then status 200
    And assert responseTime < 5000
    And assert response.username == "Karianne"

  @createUser @regression @negative
  Scenario: create a new user
    Given path 'users'
    And request { "name": "John Doe", "username": "johnd", "email": "johnd@example.com" }
    When method post
    Then status 201
    And assert response.id != null
    And assert response.name == "John Doe"
    And assert response.username == "johnd"
    And assert response.email == "johnd@example.com"
    And print 'Created user with ID:', response.id