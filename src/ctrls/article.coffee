BaseCtrl = require './base'

class ArticleCtrl extends BaseCtrl
  constructor: (model)->
    @model = model

module.exports = ArticleCtrl
