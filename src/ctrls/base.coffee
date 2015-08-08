class BaseCtrl
  create: (req, res, next)->
    entity = @model.build req.body
    @model.save entity, (err, result)->
      return next err if err
      res.json result

module.exports = BaseCtrl
