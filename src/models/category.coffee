BaseModel = require './base'

class Category extends BaseModel
  @name: 'category'

  constructor: (db)->
    @collection = db.collection @name

module.exports = Category
