express = require 'express'
cookieParser = require 'cookie-parser'
bodyParser = require 'body-parser'

server = do express
server.use bodyParser.json {}
server.use bodyParser.urlencoded { extended: false }
server.use do cookieParser

init = require './init'
init server, (err)->
  if err
    console.log err
    console.log err.stack
    return
  port = 10080
  server.listen port, ()->
    console.log 'listening at %s', 10080
