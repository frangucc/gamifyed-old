if device.desktop()
  window.Gamifyed = angular.module('Gamifyed', ['ui.router', 'btford.socket-io'])
else
  window.Gamifyed = angular.module("Gamifyed", [ "ionic", "btford.socket-io"])
    .run ($ionicPlatform) ->
      $ionicPlatform.ready ->
        cordova.plugins.Keyboard.hideKeyboardAccessoryBar(true) if window.cordova and window.cordova.plugins.Keyboard
        StatusBar.styleDefault() if window.StatusBar

Gamifyed.config ($stateProvider, $urlRouterProvider, $locationProvider, $httpProvider) ->
  $stateProvider
    .state 'levels',
      url: '/levels'
      controller: 'LevelsCtrl'
      templateUrl: 'levels/index.html'

    .state 'level',
      url: '/levels/:permalink'
      controller: 'LevelCtrl'
      templateUrl: 'levels/show.html'

    .state 'step',
      url: '/levels/:permalink/:step'
      controller: 'LevelCtrl'
      templateUrl: 'levels/show.html'

    $urlRouterProvider.otherwise "/levels"

    $httpProvider.interceptors.push ->
       request: (config) ->
         if config.url.match(/\.html$/)
           if device.tablet()
             type = 'tablet'
           else if device.mobile()
             type = 'mobile'
           else
             type = 'desktop'

           config.url = "/#{type}/#{config.url}"

         config

Gamifyed.run ($state) ->
  $state.go('levels')

Gamifyed.factory 'Socket', (socketFactory) ->
  socketFactory()

Gamifyed.factory 'Levels', (Socket) ->
  service =
    list: []
    find: (permalink) ->
      _.find service.list, (level) ->
        level.permalink == permalink

  Socket.on 'levels', (levels) ->
    service.list = levels

  service

Gamifyed.controller 'LevelsCtrl', ($scope, Levels) ->
  $scope.$watch (-> Levels.list), ->
    $scope.levels = Levels.list

Gamifyed.controller 'LevelCtrl', ($scope, $sce, $stateParams, $timeout, Levels) ->
  $scope.index = if $stateParams.step then $stateParams.step-1 else 0

  $scope.$watch (-> Levels.list), ->
    $scope.level = Levels.find($stateParams.permalink)
    if $scope.level
      $scope.step = $scope.level.steps[$scope.index]
      $scope.step.url = $sce.trustAsResourceUrl($scope.step.url)

      if $scope.step.type == 'dialog'
        $scope.messageIndex = 0
        $scope.messages = []
        $timeout($scope.nextMessage, 1000)

  $scope.hasMoreSteps = ->
    if $scope.step
      $scope.step.index < $scope.level.steps.length

  $scope.nextMessage = ->
    $scope.typing = true
    $timeout((->
      $scope.typing = false
      $scope.messages.push($scope.step.messages[$scope.messageIndex])
      $scope.messageIndex++
      $timeout($scope.nextMessage, 3000) if $scope.messageIndex < $scope.step.messages.length
    ), 2000)
