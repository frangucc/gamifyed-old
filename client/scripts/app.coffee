angular.module("gamifyed", [ "ionic", "gamifyed.controllers", "gamifyed.services"])
  .run ($ionicPlatform) ->
    $ionicPlatform.ready ->
      cordova.plugins.Keyboard.hideKeyboardAccessoryBar(true) if window.cordova and window.cordova.plugins.Keyboard
      StatusBar.styleDefault() if window.StatusBar

  .config ($stateProvider, $urlRouterProvider) ->
  
    $stateProvider
      .state "tab",
        url: "/tab"
        abstract: true
        templateUrl: "/tabs.html"

      .state "tab.dash",
        url: "/dash"
        views:
          "tab-dash":
            templateUrl: "/tab-dash.html"
            controller: "DashCtrl"

      .state "tab.friends",
        url: "/friends"
        views:
          "tab-friends":
            templateUrl: "/tab-friends.html"
            controller: "FriendsCtrl"

      .state "tab.friend-detail",
        url: "/friend/:friendId"
        views:
          "tab-friends":
            templateUrl: "friend-detail.html"
            controller: "FriendDetailCtrl"

      .state "tab.account",
        url: "/account"
        views:
          "tab-account":
            templateUrl: "tab-account.html"
            controller: "AccountCtrl"

    $urlRouterProvider.otherwise "/tab/dash"
