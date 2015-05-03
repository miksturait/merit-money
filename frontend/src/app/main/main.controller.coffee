angular.module('MeritMoney')

  .controller 'MainCtrl', ($scope, DataFetcher) ->
    $scope.init = ->
      DataFetcher.getUsers()
      DataFetcher.getCurrentUser()

    $scope.init()
