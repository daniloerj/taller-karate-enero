@albums
Feature: API de Albums
    Escenarios para probar GET, POST, PUT y DELETE sobre /albums

    Background:
        # baseUrl debe estar definido en karate-config.js, por ejemplo: karate-config.js -> { baseUrl: 'http://localhost:8080' }
        * url baseUrl
        * header Content-Type = 'application/json'

    Scenario: Obtener lista de albums (GET /albums)
        Given path 'albums'
        When method GET
        Then status 200

    Scenario: Crear un album (POST /albums)
        Given path 'albums'
        And request { title: 'Nuevo Álbum', artist: 'Artista X', year: 2026 }
        When method POST
        Then status 201
        And match response.id == '#number'
        * def createdId = response.id

    Scenario: Obtener album por id (GET /albums/{id})
        # Primero crear un album para obtener un id válido
        Given path 'albums'
        And request { title: 'Album para GET', artist: 'Artista Y', year: 2025 }
        When method POST
        Then status 201
        * def id = response.id

        Given path 'albums', id
        When method GET
        Then status 200
        And match response.id == id
        And match response.title == 'Album para GET'

    Scenario: Actualizar un album (PUT /albums/{id})
        # Crear album base
        Given path 'albums'
        And request { title: 'Album a actualizar', artist: 'Artista Z', year: 2020 }
        When method POST
        Then status 201
        * def idToUpdate = response.id

        # Actualización
        Given path 'albums', idToUpdate
        And request { id: idToUpdate, title: 'Album actualizado', artist: 'Artista Z', year: 2021 }
        When method PUT
        Then status 200
        And match response.id == idToUpdate
        And match response.title == 'Album actualizado'
        And match response.year == 2021

    Scenario: Eliminar un album (DELETE /albums/{id})
        # Crear album para eliminar
        Given path 'albums'
        And request { title: 'Album a eliminar', artist: 'Artista W', year: 2019 }
        When method POST
        Then status 201
        * def idToDelete = response.id

        # Eliminación
        Given path 'albums', idToDelete
        When method DELETE
        Then status 204

        # Verificar que ya no existe
        Given path 'albums', idToDelete
        When method GET
        Then status 404