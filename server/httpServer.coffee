http = require 'http'
app = require './express'

httpServer = http.createServer app

module.exports = httpServer
