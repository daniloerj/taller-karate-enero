function fn() {
  var env = karate.env; // get system property 'karate.env'
  var port = karate.properties['demo.server.port'];
  karate.log('karate.env system property was:', env);
  karate.log('Propiedades definidas por el usuario:', port);
  if (!env) {
    env = 'dev';
  }
  var config = {
    env: env,
    // Functions for later use
    generateToken: function() {
      return 'token-' + java.util.UUID.randomUUID();
    },
    myVarName: 'someValue',
    defaultHeaders: { 'Content-Type': 'application/json', 'Accept': 'application/json', 'danilo-header': 'karate-header' },
  }
  if (env == 'dev') {
    // customize
    config.baseUrl = 'https://jsonplaceholder.typicode.com',
    config.ambiente = 'development'
  } else if (env == 'qa') {
    // customize
    config.baseUrl = 'https://jsonplaceholder.typicode.com/qa',
    config.ambiente = 'Calidad'
  }
  karate.configure('connectTimeout', 5000);
  karate.configure('readTimeout', 5000);
  
  return config;
}