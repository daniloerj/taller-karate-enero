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
    * def newUser = read('user-data.json')
    * def schema = read('user-schema-post.json')
    * def token = call read('classpath:examples/auth/login.feature')
    * print 'Generated Token:', token.response.token

    Given path 'users'
    And header Authorization = 'Bearer ' + token.response.token
    And header x-numero-aleatorio = generateToken()
    And headers defaultHeaders
    And request newUser
    When method post
    Then status 201
    And assert responseTime < 5000
    And match responseHeaders['Content-Type'][0] contains 'application/json'
    And assert response.id != null
    And assert response.name == "John Doe"
    And assert response.username == "johnd"
    And assert response.email == "johnd@example.com"
    And match response == schema

    @create-multiple
    Scenario Outline: crear varios usuarios usando Examples
      * def login = call read('classpath:examples/auth/login.feature')
      * def auth = 'Bearer ' + login.response.token
      * def payload =
        """
        {
          "name": "<name>",
          "username": "<username>",
          "email": "<email>"
        }
        """
      * def randomHeader = 
        """
        function() {
          var min = 1000;
          var max = 9999;
          return Math.floor(Math.random() * (max - min + 1)) + min;
        }
        """

      Given path 'users'
      And header Authorization = auth
      And headers defaultHeaders
      And header x-numero-aleatorio = randomHeader
      And request payload
      When method post
      Then status <expectedStatus>
      And match response.name == '<name>'
      And match response.username == '<username>'
      And match response.email == '<email>'

    Examples:
      | read('classpath:examples/common/test-data.json')[0].users|