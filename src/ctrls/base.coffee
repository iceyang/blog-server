async = require 'async'

utils = require '../utils'

class BaseCtrl
  params:
    getId: (req, res, next, id) ->
      utils.buildObjectID id, (err, result)->
        return next err if err
        console.log "id:", result
        req.params.id = result
        do next

  create: (req, res, next)->
    @model.save req.body, (err, result)->
      return next err if err
      res.json result

  update: (req, res, next)->
    id = req.params.id
    entity = req.body
    delete entity._id
    entity.id = id
    @model.update entity, (err, result)->
      return next err if err
      res.json result

  queryById: (req, res, next)->
    id = req.params.id
    @model.findById id, (err, result)->
      return next err if err
      res.json result

  query: (req, res, next)->
    selector = req.selector
    options = req.options
    async.auto
      'list': (done)=>
        @model.find selector, options, done
      'count': (done)=>
        @model.count selector, done
      (err, results)->
        return next err if err
        skip = if options.skip then options.skip + options.limit else options.limit
        res.json
          list: results.list
          residue: Math.max 0, results.count - skip
          total: results.count

  next: (req, res, next)->
    req.selector = req.selector || {}
    req.selector._id = {$gt: req.params.id} if req.params.id
    req.options = req.options || {}
    req.options.limit = req.query?.limit || 10
    @query req, res, next

  all: (req, res, next)->
    selector = {}
    options = {}
    @model.find selector, options, (err, results)->
      return next err if err
      res.json results

module.exports = BaseCtrl
