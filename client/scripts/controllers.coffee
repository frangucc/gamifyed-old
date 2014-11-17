angular.module("gamifyed.controllers", [])
  .controller "DashCtrl", ($scope) ->
    true

  .controller "FriendsCtrl", ($scope, Friends) ->
    $scope.friends = Friends.all()

  .controller "FriendDetailCtrl", ($scope, $stateParams, Friends) ->
    $scope.friend = Friends.get($stateParams.friendId)

  .controller "AccountCtrl", ($scope) ->
    true
