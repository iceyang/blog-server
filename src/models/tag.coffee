BaseModel = require './base'

class Tag extends BaseModel
  @rule:
    name: {required: true}

  @name: 'tag'

  constructor: (db)->
    @collection = db.collection @name

module.exports = Tag
