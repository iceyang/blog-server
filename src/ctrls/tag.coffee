BaseCtrl = require './base'

class TagCtrl extends BaseCtrl
  constructor: (models)->
    @name = 'tag'
    @model = models.Tag

module.exports = TagCtrl
