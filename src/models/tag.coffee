BaseModel = require './base'

class Tag extends BaseModel
  @name: 'tag'

  constructor: (db)->
    @collection = db.collection @name

module.exports = Tag
