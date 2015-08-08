MongoClient = require('mongodb').MongoClient

url = 'mongodb://blog:iceyang1007#gmail.com@iceyang.digital.com:27025/blog'

module.exports =
  init: (callback)->
    MongoClient.connect url, callback
