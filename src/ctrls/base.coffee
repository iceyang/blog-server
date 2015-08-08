class BaseCtrl
  create: (req, res, next)->
    try
      entity = @model.build req.body
    catch err
      next err
    @model.save entity, (err, result)->
      return next err if err
      res.json result

  update: (req, res, next)->
    @model.update req.body, (err, result)->
      return next err if err
      res.json result

  queryById: (req, res, next)->
    id = req.params.id
    @model.findById id, (err, result)->
      return next err if err
      res.json result

module.exports = BaseCtrl
