module.exports = (server, ctrls)->
  server.param 'tagId', ctrls.Tag.params.getId
  server.post '/tags', ctrls.Tag.create
  server.get  '/tags/:tagId', ctrls.Tag.queryById
