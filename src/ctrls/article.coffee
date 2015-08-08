BaseCtrl = require './base'

class ArticleCtrl extends BaseCtrl
  constructor: (models)->
    @name = 'article'
    @model = models.Article

module.exports = ArticleCtrl
