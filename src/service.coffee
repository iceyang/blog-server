express = require 'express'
cookieParser = require 'cookie-parser'
bodyParser = require 'body-parser'

server = do express
server.use bodyParser.json {}
server.use bodyParser.urlencoded { extended: false }
server.use do cookieParser

route = require './route'
route server

port = 8003
server.listen port, ()->
  console.log 'listening at %s', 8003
