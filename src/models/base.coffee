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
    async.series [
      (done)=> @checkFields model, done
      (done)=>
        @collection.findOneAndUpdate {_id: _id}, {$set: model}, {returnOriginal:false, upsert: false}, (err, result) ->
          return done err if err
          callback null, result?.value or {}
    ], (err)->
      callback err if err

  remove: (model, callback)->
    @collection.remove {_id: model._id}, callback

  findById: (id, callback)->
    @collection.findOne {_id: id}, callback

module.exports = BaseModel
