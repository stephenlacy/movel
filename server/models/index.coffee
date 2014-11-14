mongoose = require "mongoose"

module.exports.User = mongoose.model "User", require "./User"
module.exports.Item = mongoose.model "Item", require "./Item"
