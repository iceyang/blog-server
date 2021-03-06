// Generated by CoffeeScript 1.9.2
(function() {
  var BaseCtrl, async, utils;

  async = require('async');

  utils = require('../utils');

  BaseCtrl = (function() {
    function BaseCtrl() {}

    BaseCtrl.prototype.params = {
      getId: function(req, res, next, id) {
        return utils.buildObjectID(id, function(err, result) {
          if (err) {
            return next(err);
          }
          console.log("id:", result);
          req.params.id = result;
          return next();
        });
      }
    };

    BaseCtrl.prototype.create = function(req, res, next) {
      return this.model.save(req.body, function(err, result) {
        if (err) {
          return next(err);
        }
        return res.json(result);
      });
    };

    BaseCtrl.prototype.update = function(req, res, next) {
      var entity, id;
      id = req.params.id;
      entity = req.body;
      delete entity._id;
      entity.id = id;
      return this.model.update(entity, function(err, result) {
        if (err) {
          return next(err);
        }
        return res.json(result);
      });
    };

    BaseCtrl.prototype.queryById = function(req, res, next) {
      var id;
      id = req.params.id;
      return this.model.findById(id, function(err, result) {
        if (err) {
          return next(err);
        }
        return res.json(result);
      });
    };

    BaseCtrl.prototype.query = function(req, res, next) {
      var options, selector;
      selector = req.selector;
      options = req.options;
      return async.auto({
        'list': (function(_this) {
          return function(done) {
            return _this.model.find(selector, options, done);
          };
        })(this),
        'count': (function(_this) {
          return function(done) {
            return _this.model.count(selector, done);
          };
        })(this)
      }, function(err, results) {
        var skip;
        if (err) {
          return next(err);
        }
        skip = options.skip ? options.skip + options.limit : options.limit;
        return res.json({
          list: results.list,
          residue: Math.max(0, results.count - skip),
          total: results.count
        });
      });
    };

    BaseCtrl.prototype.next = function(req, res, next) {
      var ref;
      req.selector = req.selector || {};
      if (req.params.id) {
        req.selector._id = {
          $gt: req.params.id
        };
      }
      req.options = req.options || {};
      req.options.limit = ((ref = req.query) != null ? ref.limit : void 0) || 10;
      return this.query(req, res, next);
    };

    BaseCtrl.prototype.all = function(req, res, next) {
      var options, selector;
      selector = {};
      options = {};
      return this.model.find(selector, options, function(err, results) {
        if (err) {
          return next(err);
        }
        return res.json(results);
      });
    };

    return BaseCtrl;

  })();

  module.exports = BaseCtrl;

}).call(this);
