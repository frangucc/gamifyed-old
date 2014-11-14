window.Futbol = angular.module('Futbol', ['ngRoute', 'btford.socket-io'])

Futbol.config ($routeProvider) ->
  $routeProvider
    .when '/',
      controller: 'LevelsCtrl'
      templateUrl: 'levels/index.html'

    .when '/levels/:permalink',
      controller: 'LevelCtrl'
      templateUrl: 'levels/show.html'

    .when '/levels/:permalink/:step',
      controller: 'LevelCtrl'
      templateUrl: 'levels/show.html'

Futbol.factory 'Socket', (socketFactory) ->
  socketFactory()

Futbol.factory 'Levels', (Socket) ->
  service =
    list: []
    find: (permalink) ->
      _.find service.list, (level) ->
        level.permalink == permalink

  Socket.on 'levels', (levels) ->
    service.list = levels

  service

Futbol.controller 'LevelsCtrl', ($scope, Levels) ->
  $scope.$watch (-> Levels.list), ->
    $scope.levels = Levels.list

Futbol.controller 'LevelCtrl', ($scope, $sce, $routeParams, Levels) ->
  $scope.index = if $routeParams.step then $routeParams.step-1 else 0

  $scope.$watch (-> Levels.list), ->
    $scope.level = Levels.find($routeParams.permalink)
    if $scope.level
      $scope.step = $scope.level.steps[$scope.index]
      $scope.step.url = $sce.trustAsResourceUrl($scope.step.url)

  $scope.hasMoreSteps = ->
    if $scope.step
      $scope.step.index < $scope.level.steps.length
