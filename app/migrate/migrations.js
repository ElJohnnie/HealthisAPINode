var migration = require('mysql-migrations');
const connection = require('../models/db');
console.log(connection);

migration.init(connection, __dirname + '/migrate');