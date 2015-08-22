async = require 'async'

class BaseModel
  build: (object, callback)->
    entity = {}
    for key, options of @rule
      if options?
        return callback new Error("#{key} must be required") if options.required && not object[key]
      entity[key] = object[key]
    callback null, entity

  checkFields: (object, callback)->
    for key, value of object
      if not @rule[key]
        return callback new Error("not such field #{key}")
      options = @rule[key]
      # TODO do something, egs: type check
    callback null

  save: (model, callback)->
    @build model, (err, entity)=>
      return callback err if err
      @collection.insert entity, (err, result)->
        callback err, result?.ops?[0] or {}

  update: (model, callback)->
    _id = model.id
    delete model.id
    async.auto
      "check": (done)=> @checkFields model, done
      "update": ['check', (done)=>
        @collection.findOneAndUpdate {_id: _id}, {$set: model}, {returnOriginal:false, upsert: false}, (err, result) ->
          done err, result?.value or {}
      ]
      (err, results)->
        callback err, results.update

  remove: (model, callback)->
    @collection.remove {_id: model._id}, callback

  findById: (id, callback)->
    @collection.findOne {_id: id}, callback

  find: (selector, options, callback)->
    @collection.find(selector, options).toArray callback

  count: (selector, options, callback)->
    callback = options unless callback
    @collection.count selector, callback

module.exports = BaseModel
