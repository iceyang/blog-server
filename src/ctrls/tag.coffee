utils = require '../utils'
BaseCtrl = require './base'

class TagCtrl extends BaseCtrl
  constructor: (models)->
    @name = 'tag'
    @model = models.Tag

  params:
    getId: (req, res, next, id) ->
      utils.buildObjectID id, (err, result)->
        return next err if err
        req.params.tagId = result
        do next

module.exports = TagCtrl
