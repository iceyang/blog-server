BaseCtrl = require './base'

class TagCtrl extends BaseCtrl
  constructor: (models)->
    @model = models.Tag

module.exports = TagCtrl
