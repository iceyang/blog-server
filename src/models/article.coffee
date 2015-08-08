BaseModel = require './base'

class Article extends BaseModel
  @rule:
    category: {required: false}
    tags: {required: false}
    title: {required: true}
    content: {required: true}
    cover: {required: false} # 封面
    publishTime: {required: false}
    lastUpdate: {required: false}

  @name: 'article'

  constructor: (db)->
    @collection = db.collection @name

module.exports = Article
