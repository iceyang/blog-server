// Generated by CoffeeScript 1.9.2
(function() {
  var boxing, boxingControllers, ctrls, models;

  models = require('./models');

  boxing = function(ctrl) {
    var box, name, value;
    box = {
      model: ctrl.model
    };
    for (name in ctrl) {
      value = ctrl[name];
      if (typeof value !== 'function') {
        continue;
      }
      if (name === 'constructor') {
        continue;
      }
      switch (value.length) {
        case 3:
          box[name] = (function(name) {
            return function(req, res, next) {
              console.log('%s handler:%s', ctrl.name, name);
              return ctrl[name](req, res, next);
            };
          })(name);
          break;
        default:
          console.log('unknown handler: %s, args length: %d', name, value.length);
      }
    }
    return box;
  };

  boxingControllers = function(ctrls) {
    var ctrl, ctrlName, result;
    result = {};
    for (ctrlName in ctrls) {
      ctrl = ctrls[ctrlName];
      result[ctrlName] = boxing(ctrl);
    }
    return result;
  };

  ctrls = boxingControllers(require('./controllers'));

  module.exports = function(server) {};

}).call(this);
