angular.module('MeritMoney')

  .service 'DataFetcher', [ '$rootScope', 'Api', ($rootScope, Api) ->
    getUsers: ->
      Api.get('users.json').then (data) ->
        $rootScope.users = data.users
        $rootScope.users.forEach (user) ->
          user.kudo_received = Api.idsToObjects(user.kudo_received_ids, data.kudo_receiveds)
          user.newKudo = value: 1, comment: '', receiver_id: user.id

    getCurrentUser: ->
      Api.get('current_users/1.json').then (data) ->
        $rootScope.kudosLeftNum = data.current_user.kudos_left
        $rootScope.kudosReceived = data.current_user.kudos_received
        $rootScope.kudosTotalReceived = data.current_user.kudos_total_received
        $rootScope.trend = data.current_user.trend
  ]