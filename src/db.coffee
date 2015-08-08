MongoClient = require('mongodb').MongoClient

url = 'mongodb://iceyang:iceyang1007#gmail.com@localhost:27025/blog'

module.exports =
  init: (callback)->
    MongoClient.connect url, callback
