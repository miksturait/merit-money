angular.module('MeritMoney')

  .controller 'MainCtrl', ($scope, Api) ->
    $scope.init = ->
      $scope.fetchData()

    $scope.rate = 1

    $scope.fetchData = ->
      Api.get('users.json').then (data) ->
        $scope.users = data.users
        $scope.users.forEach (user) ->
          user.kudo_received = Api.idsToObjects(user.kudo_received_ids, data.kudo_receiveds)

    $scope.init()
