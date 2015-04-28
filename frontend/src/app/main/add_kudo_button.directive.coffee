angular.module('MeritMoney')

  .directive 'addKudoButton', (Api, DataFetcher) ->
    restrict: 'E'
    template: '<span class="btn btn-primary">add</span>'
    scope:
      user: '='

    link: (scope, element, attrs) ->
      element.on 'click', ->
        Api.post('/kudos.json', null, {kudo: scope.user.newKudo}).then ->
          DataFetcher.getUsers()
          DataFetcher.getCurrentUser()
