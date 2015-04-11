angular.module('MeritMoney')

  .controller 'MainCtrl', ($scope, Api) ->
    $scope.init = ->
      $scope.rate = 1
      $scope.fetchData()

    $scope.addKudo = (user) ->
      attrs = receiver_id: user.id, value: $scope.rate, comment: ''
      Api.post('/kudos.json', null, {kudo: attrs}).then -> $scope.fetchData()

    $scope.setRate = (value) ->
      $scope.rate = value

    $scope.fetchData = ->
      Api.get('users.json').then (data) ->
        $scope.users = data.users
        $scope.users.forEach (user) ->
          user.kudo_received = Api.idsToObjects(user.kudo_received_ids, data.kudo_receiveds)

    $scope.init()
