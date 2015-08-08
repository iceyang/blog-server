BaseModel = require './base'

class Tag extends BaseModel
  constructor: (db)->
    @collection = db.collection 'tag'
    @rule =
      name: {required: true}

module.exports = Tag
