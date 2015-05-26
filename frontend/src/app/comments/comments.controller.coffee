angular.module('MeritMoney')

  .controller "CommentsCtrl", ($scope, DataFetcher) ->
    $scope.init = ->
      DataFetcher.getCurrentUser()
      DataFetcher.getComments()

    $scope.init()
