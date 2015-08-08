BaseModel = require './base'

class Article extends BaseModel
  @name: 'article'

  constructor: (db)->
    @collection = db.collection @name

module.exports = Article
