angular.module('MeritMoney')

  .controller 'MainCtrl', ($scope, Api) ->
    $scope.init = ->
      $scope.fetchData()

    $scope.addKudo = (user) ->
      Api.post('/kudos.json', null, {kudo: user.newKudo}).then -> $scope.fetchData()

    $scope.fetchData = ->
      Api.get('users.json').then (data) ->
        $scope.users = data.users
        $scope.users.forEach (user) ->
          user.kudo_received = Api.idsToObjects(user.kudo_received_ids, data.kudo_receiveds)
          user.newKudo = value: 1, comment: '', receiver_id: user.id

      Api.get('current_users/1.json').then (data) ->
        $scope.kudosLeftNum = data.current_user.kudos_left
        $scope.kudosReceived = data.current_user.kudos_received
        $scope.kudosTotalReceived = data.current_user.kudos_total_received
        $scope.trend = data.current_user.trend

    $scope.$watch 'trend', ->
      klass = switch $scope.trend
        when 'steady' then 'steady glyphicon-minus'
        when 'upward' then 'upward glyphicon-chevron-up'
        when 'downward' then 'downward glyphicon-chevron-down'
      $scope.trendClass = "trend glyphicon #{klass}"

    $scope.init()
