angular.module("Gamifyed.Services", [])
  .factory "Friends", ->
    friends = [
      {
        id: 0
        name: "Scruff McGruff"
      }
      {
        id: 1
        name: "G.I. Joe"
      }
      {
        id: 2
        name: "Miss Frizzle"
      }
      {
        id: 3
        name: "Ash Ketchum"
      }
    ]

    all: ->
      friends

    get: (friendId) ->
      friends[friendId]
