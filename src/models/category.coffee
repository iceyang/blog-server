BaseModel = require './base'

class Category extends BaseModel
  @rule:
    name: {required: true}

  @name: 'category'

  constructor: (db)->
    @collection = db.collection @name

module.exports = Category
