MongoClient = require('mongodb').MongoClient

url = (require './config').dbUrl

module.exports =
  init: (callback)->
    MongoClient.connect url, callback
