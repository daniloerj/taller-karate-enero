@ignore
Feature: Obtener token de autenticación desde restful-booker

    Background:
        * url 'https://restful-booker.herokuapp.com'

    @generateToken @auth @smoke
    Scenario: Obtener token válido
        Given path 'auth'
        And request { username: 'admin', password: 'password123' }
        When method post
        Then status 200
        And match response.token != null
        * def authToken = response.token
        * print 'Auth token:', authToken