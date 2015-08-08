BaseCtrl = require './base'

class CategoryCtrl extends BaseCtrl
  constructor: (models)->
    @model = models.Category

module.exports = CategoryCtrl
