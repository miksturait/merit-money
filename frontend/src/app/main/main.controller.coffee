angular.module('MeritMoney')

  .controller 'MainCtrl', [ '$scope', 'DataFetcher', ($scope, DataFetcher) ->
    $scope.init = ->
      DataFetcher.getUsers()
      DataFetcher.getCurrentUser()

    $scope.addKudo = (user) ->
      Api.post('/kudos.json', null, {kudo: user.newKudo}).then -> $scope.fetchData()

    $scope.$watch 'trend', ->
      klass = switch $scope.trend
        when 'steady' then 'steady glyphicon-minus'
        when 'upward' then 'upward glyphicon-chevron-up'
        when 'downward' then 'downward glyphicon-chevron-down'
      $scope.trendClass = "trend glyphicon #{klass}"

    $scope.init()
  ]
