// Generated by CoffeeScript 1.9.2
(function() {
  module.exports = function(server, ctrls) {
    server.param('tagId', ctrls.Tag.params.getId);
    server.post('/tags', ctrls.Tag.create);
    return server.get('/tags/:tagId', ctrls.Tag.queryById);
  };

}).call(this);
