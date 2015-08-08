models = require './models'

boxing = (ctrl)->
  box = {model: ctrl.model}
  for name, value of ctrl
    continue unless typeof value is 'function'
    continue if name is 'constructor'
    switch value.length
      when 3 then box[name] = do (name) -> (req, res, next) ->
        console.log '%s handler:%s', ctrl.name, name
        ctrl[name] req, res, next
      else console.log 'unknown handler: %s, args length: %d', name, value.length
  return box

boxingControllers = (ctrls)->
  result = {}
  for ctrlName, ctrl of ctrls
    result[ctrlName] = boxing ctrl
  return result

ctrls = boxingControllers (require './controllers')

module.exports = (server)->
