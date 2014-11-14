{join} = require 'path'

module.exports =
  port: 5000,
  name: 'Movel',
  database: 'mongodb://localhost:27017/quare'
  pubdir: join __dirname, '../../public'
