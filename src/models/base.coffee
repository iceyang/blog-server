class BaseModel
  build: (object)->
    entity = {}
    for key, options of @rule
      if options?
        throw new Error("#{key} must be required") if options.required && not object[key]
      entity[key] = object[key]
    return entity

  save: (model, callback)->
    @collection.insert model, (err, result)->
      callback err, result?.ops?[0] or {}

  update: (model, callback)->
    _id = model._id
    delete model._id
    @collection.findOneAndUpdate {_id: _id}, {$set: model}, {returnOriginal:false, upsert: false}, (err, result) ->
      return callback err if err
      callback null, result?.value or {}

  remove: (model, callback)->
    @collection.remove {_id: model._id}, callback

  findById: (id, callback)->
    @collection.findOne {_id: id}, callback

module.exports = BaseModel
