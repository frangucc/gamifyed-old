module.exports = (socket) ->
  socket.emit('sports', ['soccer', 'baseball'])
