// Generated by CoffeeScript 1.9.2
(function() {
  var BaseModel, async;

  async = require('async');

  BaseModel = (function() {
    function BaseModel() {}

    BaseModel.prototype.build = function(object, callback) {
      var entity, key, options, ref;
      entity = {};
      ref = this.rule;
      for (key in ref) {
        options = ref[key];
        if (options != null) {
          if (options.required && !object[key]) {
            return callback(new Error(key + " must be required"));
          }
        }
        entity[key] = object[key];
      }
      return callback(null, entity);
    };

    BaseModel.prototype.checkFields = function(object, callback) {
      var key, options, value;
      for (key in object) {
        value = object[key];
        if (!this.rule[key]) {
          return callback(new Error("not such field " + key));
        }
        options = this.rule[key];
      }
      return callback(null);
    };

    BaseModel.prototype.save = function(model, callback) {
      return this.build(model, (function(_this) {
        return function(err, entity) {
          if (err) {
            return callback(err);
          }
          return _this.collection.insert(entity, function(err, result) {
            var ref;
            return callback(err, (result != null ? (ref = result.ops) != null ? ref[0] : void 0 : void 0) || {});
          });
        };
      })(this));
    };

    BaseModel.prototype.update = function(model, callback) {
      var _id;
      _id = model.id;
      delete model.id;
      return async.auto({
        "check": (function(_this) {
          return function(done) {
            return _this.checkFields(model, done);
          };
        })(this),
        "update": [
          'check', (function(_this) {
            return function(done) {
              return _this.collection.findOneAndUpdate({
                _id: _id
              }, {
                $set: model
              }, {
                returnOriginal: false,
                upsert: false
              }, function(err, result) {
                return done(err, (result != null ? result.value : void 0) || {});
              });
            };
          })(this)
        ]
      }, function(err, results) {
        return callback(err, results.update);
      });
    };

    BaseModel.prototype.remove = function(model, callback) {
      return this.collection.remove({
        _id: model._id
      }, callback);
    };

    BaseModel.prototype.findById = function(id, callback) {
      return this.collection.findOne({
        _id: id
      }, callback);
    };

    BaseModel.prototype.find = function(selector, options, callback) {
      return this.collection.find(selector, options).toArray(callback);
    };

    BaseModel.prototype.count = function(selector, options, callback) {
      if (!callback) {
        callback = options;
      }
      return this.collection.count(selector, callback);
    };

    return BaseModel;

  })();

  module.exports = BaseModel;

}).call(this);
