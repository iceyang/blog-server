// Generated by CoffeeScript 1.9.2
(function() {
  var ArticleCtrl, BaseCtrl, marked,
    extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  marked = require('marked');

  BaseCtrl = require('./base');

  ArticleCtrl = (function(superClass) {
    extend(ArticleCtrl, superClass);

    function ArticleCtrl(models) {
      this.name = 'article';
      this.model = models.Article;
    }

    ArticleCtrl.prototype.queryCondition = function(req, res, next) {
      var current, fields, limit, skip;
      fields = {};
      limit = req.body.limit || 20;
      current = Math.max(1, req.body.current);
      skip = (current - 1) * limit;
      req.selector = {};
      req.options = {
        fields: fields,
        skip: skip,
        limit: limit,
        sort: [['_id', -1]]
      };
      return next();
    };

    ArticleCtrl.prototype.create = function(req, res, next) {
      req.body.publishTime = new Date();
      req.body.lastUpdate = new Date();
      return ArticleCtrl.__super__.create.call(this, req, res, next);
    };

    ArticleCtrl.prototype.update = function(req, res, next) {
      req.body.lastUpdate = new Date();
      return ArticleCtrl.__super__.update.call(this, req, res, next);
    };

    ArticleCtrl.prototype.queryById = function(req, res, next) {
      var id;
      id = req.params.id;
      return this.model.findById(id, function(err, result) {
        if (err) {
          return next(err);
        }
        result.content = marked(result.content);
        return res.json(result);
      });
    };

    ArticleCtrl.prototype.list = function(req, res, next) {
      var ref, ref1, ref2, ref3;
      req.selector = req.body.selector || {};
      req.options = {
        limit: ((ref = req.body) != null ? (ref1 = ref.options) != null ? ref1.limit : void 0 : void 0) || 20,
        skip: ((ref2 = req.body) != null ? (ref3 = ref2.options) != null ? ref3.skip : void 0 : void 0) || 0
      };
      return this.query(req, res, next);
    };

    ArticleCtrl.prototype.next = function(req, res, next) {
      req.options = {
        fields: {
          content: false
        }
      };
      return ArticleCtrl.__super__.next.call(this, req, res, next);
    };

    return ArticleCtrl;

  })(BaseCtrl);

  module.exports = ArticleCtrl;

}).call(this);
