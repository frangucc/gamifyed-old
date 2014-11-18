express = require('express')
app = express()
server = require('http').Server(app)
io = require('socket.io')(server)
socketHandler = require('./lib/socketHandler')

server.listen(process.env.PORT || 3000)

app.use('/', express.static(__dirname + '/www'))

app.get '/config.json', (request, response) ->
  response.json
    socketUrl: "http://localhost:3000/socket.io"

io.on('connection', socketHandler)
