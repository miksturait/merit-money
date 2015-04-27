angular.module('MeritMoney', [
  'ngAnimate'
  'ngCookies'
  'ngTouch'
  'ngSanitize'
  'restangular'
  'ngRoute'
  'ui.bootstrap'
  'angular.filter'
])

  .config ($routeProvider) ->
    $routeProvider
    .when "/",
      templateUrl: "app/main/main.html"
      controller: "MainCtrl"
    .when "/comments",
      templateUrl: "app/comments/comments.html"
      controller: "CommentsCtrl"
    .otherwise
      redirectTo: "/"
