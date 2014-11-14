OBDReader = require 'bluetooth-obd'
btSerial = new OBDReader()

io = require './sockets'

btSerial.on 'connected', ->
  io.emit 'bt:success'
  @requestValueByName 'rpm' #vss
  @addPoller 'vss'
  @addPoller 'rpm'
  @addPoller 'temp'
  @addPoller 'load_pct'
  @addPoller 'map'
  #@addPoller 'pidsupp0'
  #@addPoller 'frp'
  #@addPoller 'runtm'
  #@addPoller 'fli'
  @addPoller 'throttlepos'
  @startPolling 500


btSerial.on 'error', (data) ->
  console.log 'Error: ' + data
  io.emit 'bt:error', error: data

btSerial.on 'debug', (data) ->
  console.log 'Debug: ' + data


io.on 'connection', (socket) ->
  socket.bt = false unless socket.bt
  socket.emit 'bt', bt: socket.bt

  console.log 'socket:connected'
  btSerial.on 'dataReceived', (data) ->
    socket.emit 'bt:data', data

  socket.on 'bt:connect', ->
    socket.bt = true
    console.log 'Attempting to connect to bt'
    btSerial.autoconnect 'obd'
