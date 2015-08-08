Article = require './article'
Category = require './category'
Tag = require './tag'

module.exports = (db)->
  Article: new Article(db)
  Category: new Category(db)
  Tag: new Tag(db)
