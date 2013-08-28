ns = require 'node-static'
file = new ns.Server './public'

server = require('http').createServer (request, response) ->
  request.addListener 'end', ->
    file.serve(request, response)
  .resume()

io = require('socket.io').listen(server)

io.sockets.on 'connection', (socket) ->
  socket.emit 'count', { count: io.sockets.clients().length }
  socket.on 'message', (data) ->
    io.sockets.emit 'message', data
server.listen process.env.PORT or 8080
