BaseCtrl = require './base'

class ArticleCtrl extends BaseCtrl
  constructor: (models)->
    @model = models.Article

module.exports = ArticleCtrl
