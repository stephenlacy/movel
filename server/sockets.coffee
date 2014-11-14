server = require './httpServer'
io = require('socket.io')(server)

module.exports = io
