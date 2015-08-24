dontNeedParseMarkdown = (req, res, next)->
  req.params.dontNeedParseMarkdown = true
  do next

module.exports = (server, ctrls)->
  server.param 'tagId', ctrls.Tag.params.getId
  server.post '/tags', ctrls.Tag.create
  server.get '/tags/all', ctrls.Tag.all
  server.get '/tags/:tagId', ctrls.Tag.queryById
  server.put '/tags/:tagId', ctrls.Tag.update
 
  server.param 'categorieId', ctrls.Category.params.getId
  server.post '/categories', ctrls.Category.create
  server.get '/categories/all', ctrls.Category.all
  server.get  '/categories/:categoryId', ctrls.Category.queryById
  server.put  '/categories/:categoryId', ctrls.Category.update
 
  server.param 'articleId', ctrls.Article.params.getId
  server.get  '/articles/first', ctrls.Article.next
  server.get  '/articles/next/:articleId', ctrls.Article.next
  server.get  '/articles/:articleId', dontNeedParseMarkdown, ctrls.Article.queryById
  server.post '/articles', ctrls.Article.create
  server.put  '/articles/:articleId', ctrls.Article.update
  server.post '/articles/query', ctrls.Article.queryCondition, ctrls.Article.query

  #the route which has the prefix api is used for frontend.
  server.get '/api/articles/:articleId', ctrls.Article.queryById
