angular.module('MeritMoney')

  .service 'DataFetcher', ($rootScope, Api) ->
    getUsers: ->
      Api.get('users.json').then (data) ->
        $rootScope.users = data.users
        $rootScope.users.forEach (user) ->
          user.kudo_received = Api.idsToObjects(user.kudo_received_ids, data.kudo_receiveds)
          user.newKudo = value: 1, comment: '', receiver_id: user.id

    getCurrentUser: ->
      Api.get('current_users/1.json').then (data) ->
        $rootScope.currentUser = {}
        $rootScope.currentUser.kudosLeftNum = data.current_user.kudos_left
        $rootScope.currentUser.kudosReceived = data.current_user.kudos_received
        $rootScope.currentUser.kudosTotalReceived = data.current_user.kudos_total_received
        $rootScope.currentUser.trend = data.current_user.trend
        $rootScope.currentUser.email = data.current_user.email

    getComments: ->
      Api.get('my_comments.json').then (data) ->
        $rootScope.myComments = data.my_comments

      Api.get('other_comments.json').then (data) ->
        $rootScope.otherComments = data.other_comments
