{join} = require 'path'

express = require 'express'
staticFiles = require 'serve-static'

config = require './config'

app = express()
app.disable 'x-powered-by'

app.use staticFiles config.pubdir

idxFile = join config.pubdir, 'index.html'


app.get '/*', (req, res) ->
  res.sendFile idxFile


module.exports = app
