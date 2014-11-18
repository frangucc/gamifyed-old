levels = [
  {
    permalink: 'messi'
    player:
      name: "Messi"
    steps: [
      {index: 1, type: 'photo', url: 'http://i.forbesimg.com/media/lists/people/lionel-messi_416x416.jpg', caption: 'Hey there!!!! This is me'}
      {index: 2, type: 'video', url: 'http://www.youtube.com/embed/gW2UWuPTekk', caption: 'Watch this video'}
      {index: 3, type: 'photo', url: 'http://i.dailymail.co.uk/i/pix/2014/06/09/article-2653332-0F79C42300000578-150_634x435.jpg', caption: 'This is my first game'}
      {index: 4, type: 'dialog', messages: [
          "Hey there, I'm Lionel Messi, are you ready to begin?",
          "This is how its done.... got it?",
          "Great, now go have fun"
        ]}
    ]
  },
  {
    permalink: 'ronaldo'
    player:
      name: "Ronaldo"
    steps: [
    ]
  }
]

module.exports = (socket) ->
  socket.emit('levels', levels)
