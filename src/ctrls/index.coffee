module.exports = (models)->
  Article: new (require './article')(models)
  Category: new (require './category')(models)
  Tag: new (require './tag')(models)
