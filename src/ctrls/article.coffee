marked = require 'marked'

BaseCtrl = require './base'

class ArticleCtrl extends BaseCtrl
  constructor: (models)->
    @name = 'article'
    @model = models.Article

  queryCondition: (req, res, next) ->
    fields = {}
    limit = req.body.limit or 20
    current = Math.max 1, req.body.current
    skip = (current - 1) * limit
    req.selector = {}
    req.options = {fields, skip, limit, sort:[['_id',-1]]}
    do next

  create: (req, res, next)->
    req.body.publishTime = new Date()
    req.body.lastUpdate = new Date()
    super req, res, next

  update: (req, res, next)->
    req.body.lastUpdate = new Date()
    super req, res, next

  queryById: (req, res, next)->
    id = req.params.id
    @model.findById id, (err, result)->
      return next err if err
      result.content = marked result.content
      res.json result

  list: (req, res, next)->
    req.selector = req.body.selector || {}
    req.options =
      limit: req.body?.options?.limit || 20
      skip: req.body?.options?.skip || 0
    @query req, res, next

  next: (req, res, next)->
    req.options =
      fields:
        content: false
    super req, res, next

module.exports = ArticleCtrl
