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

      Api.get('current_users/1.json').then (data) ->
        $scope.kudosLeftNum = data.current_user.kudos_left
        $scope.kudosReceived = data.current_user.kudos_received
        $scope.kudosTotalReceived = data.current_user.kudos_total_received
        $scope.trend = data.current_user.trend

    $scope.trendClass = ->
      trendClass = switch $scope.trend
        when 'steady' then 'steady glyphicon-minus'
        when 'upward' then 'upward glyphicon-chevron-up'
        when 'downward' then 'downward glyphicon-chevron-down'
      "trend glyphicon #{trendClass}"

    $scope.init()
