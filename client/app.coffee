Fission = require 'fission'

window.fission = new Fission()

fission.config =
  name: 'Movel'

fission.io = io()
fission.io.on 'connect', ->
  console.log 'io:connected'

module.exports = fission
