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
    entity.id = id
    @model.update entity, (err, result)->
      return next err if err
      res.json result

  queryById: (req, res, next)->
    id = req.params.id
    @model.findById id, (err, result)->
      return next err if err
      res.json result

module.exports = BaseCtrl
