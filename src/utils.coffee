mongodb = require 'mongodb'

module.exports =
  buildObjectID: (value, callback) ->
    try
      id = new mongodb.ObjectID value
      callback null, id
    catch err
      callback err
