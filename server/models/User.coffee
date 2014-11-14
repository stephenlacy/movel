{Schema} = require "mongoose"


User = new Schema
  auth:
    type: Number
    default: 0

  name:
    type: String

  handle:
    type: String
    required: true

  image:
    type: String
    default: "/img/user.png"

  background:
    type: String
    default: "/img/use-background.png"

  firstLogin:
    type: Boolean
    default: true
    hidden: true

  provider:
    type: String
    hidden: true

  twid:
    type: Number

  token:
    type: String
    hidden: true

User.set "autoindex", false
module.exports = User
