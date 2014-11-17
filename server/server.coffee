express = require('express')
app = express()
server = require('http').Server(app)
io = require('socket.io')(server)
socketHandler = require('./lib/socketHandler')

server.listen(process.env.PORT || 3000)

app.use('/', express.static(__dirname + '/www'))
app.use('/lib', express.static(__dirname + '/bower_components'))

io.on('connection', socketHandler)