angular.module('MeritMoney')

  .directive 'trend', ->
    restrict: 'A'

    link: (scope, element) ->
      scope.$watch 'trend', ->
        klass = switch scope.trend
          when 'steady' then 'steady glyphicon-minus'
          when 'upward' then 'upward glyphicon-chevron-up'
          when 'downward' then 'downward glyphicon-chevron-down'
        $(element).addClass("trend glyphicon #{klass}")
