{join} = require 'path'

app = require './express'
config = require './config'
httpServer = require './httpServer'
io = require './sockets'

httpServer.listen config.port, ->
  console.log 'info', "Server running on #{config.port}"

bt = require './bt'
