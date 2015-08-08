module.exports = (models)->
  ArticleCtrl: new (require './article')(models)
  CategoryCtrl: new (require './category')(models)
  TagCtrl: new (require './tag')(models)
