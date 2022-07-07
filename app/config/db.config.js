require('dotenv').config();

module.exports = {
  HOST: process.env.HOST || 'localhost',
  USER: process.env.USER || 'root',
  PASSWORD: process.env.PASSWORD || null,
  DB: process.env.DATABASE || 'healthis'
};

