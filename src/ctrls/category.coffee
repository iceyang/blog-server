BaseCtrl = require './base'

class CategoryCtrl extends BaseCtrl
  constructor: (models)->
    @name = 'category'
    @model = models.Category

module.exports = CategoryCtrl
