async = require 'async'

boxing = (ctrl)->
  box = {model: ctrl.model, params:ctrl.params}
  for name, value of ctrl
    continue unless typeof value is 'function'
    continue if name is 'constructor'
    switch value.length
      when 3
        box[name] = do (name) -> (req, res, next) ->
          console.log '%s handler:%s', ctrl.name, name
          ctrl[name] req, res, next
      when 4
        box[name] = value #(req, res, next, id) -> model[name] req, res, next, id
      else console.log 'unknown handler: %s, args length: %d', name, value.length
  return box

boxingControllers = (ctrls)->
  result = {}
  for ctrlName, ctrl of ctrls
    result[ctrlName] = boxing ctrl
  return result

module.exports = (server, callback)->
  async.auto
    'db': (done)->
      (require './db').init done
    'ctrls': ['db', (done, results)->
      models = (require './models')(results.db)
      ctrls = (require './ctrls')(models)
      ctrls = boxingControllers ctrls
      done null, ctrls
    ]
    'route': ['ctrls', (done, results)->
      route = require './route'
      route server, results.ctrls
      do done
    ]
    (err, results)->
      callback err
