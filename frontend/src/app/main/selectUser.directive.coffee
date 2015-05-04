angular.module('MeritMoney')

  .directive 'selectUser', ($timeout) ->
    restrict: 'A'
    link: (scope, element) ->
      element.find('.content-basic').on 'click', ->
        # select active user
        scope.$apply ->
          scope.users.forEach (user) ->
            if user is scope.user
              user.active = !scope.user.active
            else
              user.active = false

        # scroll to selected user
        $timeout ->
          $('body').animate scrollTop: element.offset().top-95, 'slow'
