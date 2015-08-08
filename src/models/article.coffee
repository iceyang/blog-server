BaseModel = require './base'

class Article extends BaseModel
  constructor: (db)->
    @collection = db.collection 'article'
    @rule =
      category: {required: false}
      tags: {required: false}
      title: {required: true}
      content: {required: true}
      cover: {required: false} # 封面
      publishTime: {required: false}
      lastUpdate: {required: false}


module.exports = Article
