// Generated by CoffeeScript 1.9.2
(function() {
  var BaseCtrl, TagCtrl,
    extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  BaseCtrl = require('./base');

  TagCtrl = (function(superClass) {
    extend(TagCtrl, superClass);

    function TagCtrl(models) {
      this.name = 'tag';
      this.model = models.Tag;
    }

    return TagCtrl;

  })(BaseCtrl);

  module.exports = TagCtrl;

}).call(this);
