ns = require 'node-static'
file = new ns.Server './public'

server = require('http').createServer (request, response) ->
  request.addListener 'end', ->
    file.serve(request, response)
  .resume()

io = require('socket.io').listen(server)

io.sockets.on 'connection', (socket) ->
  socket.emit 'news', { hello: 'world' }
  socket.on 'my other event', (data) ->
    console.log(data)

server.listen 8080
