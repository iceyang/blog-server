async = require 'async'
express = require 'express'
cookieParser = require 'cookie-parser'
bodyParser = require 'body-parser'

server = do express
server.use bodyParser.json {}
server.use bodyParser.urlencoded { extended: false }
server.use do cookieParser

init = require './init'
init server, (err)->
  return console.log err if err
  port = 10080
  server.listen port, ()->
    console.log 'listening at %s', 10080
