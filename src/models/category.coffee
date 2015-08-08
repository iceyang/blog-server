BaseModel = require './base'

class Category extends BaseModel
  constructor: (db)->
    @collection = db.collection 'category'
    @rule =
      name: {required: true}


module.exports = Category
