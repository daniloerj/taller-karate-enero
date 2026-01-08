# Karate Project - Taller Karate Lite

Proyecto de ejemplo que contiene tests de Karate (API) usando Maven.

## Qué contiene
- Tests de ejemplo en `src/test/java/examples/...`.
- Configuración en `karate-config.js` para `baseUrl` y propiedades.

## Requisitos
- Java 11+ (recomendado 17)
- Maven 3.6+

## Ejecutar tests localmente

Desde la carpeta del proyecto (`karate-project`):

```bash
mvn test
```

Pasar una propiedad JVM (por ejemplo el puerto):

```bash
mvn test -Ddemo.server.port=8080
```

## Reportes
Karate genera reportes en `target/karate-reports/` y `target/karate-summary.html`.

## GitHub Actions
Incluimos un workflow básico en `.github/workflows/ci.yml` que ejecuta `mvn test` y sube `target/karate-reports` como artifact.

## Próximos pasos sugeridos
- Añadir badge de CI al README.
- Configurar secrets y protección de ramas si se incorpora un remote.
