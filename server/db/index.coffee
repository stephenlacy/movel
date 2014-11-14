mongoose = require 'mongoose'

models = require '../models'
config = require '../../config'

db = mongoose.connect config.mongo.url

mongoose.connection.once 'connected', ->
  console.log "connected to mongo"
mongoose.connection.on 'disconnected', ->
  db = mongoose.connect config.mongo.url


module.exports = db
module.exports.models = models
