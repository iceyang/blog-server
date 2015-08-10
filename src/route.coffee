module.exports = (server, ctrls)->
  server.param 'tagId', ctrls.Tag.params.getId
  server.post '/tags', ctrls.Tag.create
  server.get  '/tags/:tagId', ctrls.Tag.queryById
  server.post  '/tags/:tagId', ctrls.Tag.update
 
  server.param 'categorieId', ctrls.Category.params.getId
  server.post '/categories', ctrls.Category.create
  server.get  '/categories/:categoryId', ctrls.Category.queryById
  server.post  '/categories/:categoryId', ctrls.Category.update
 
  server.param 'articleId', ctrls.Article.params.getId
  server.get  '/articles/first', ctrls.Article.next
  server.get  '/articles/next/:articleId', ctrls.Article.next
  server.get  '/articles/:articleId', ctrls.Article.queryById
  server.post '/articles', ctrls.Article.create
  server.post  '/articles/:articleId', ctrls.Article.update
