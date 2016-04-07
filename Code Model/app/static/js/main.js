/**
 * Created by Erikka on 4/7/2016.
 */

var myApp = angular.module("myApp",[]);

myApp.config(function ($routeProvider) {
    $routeProvider
    .when('/', {
      templateUrl: 'pages/landing.html',
      access: {restricted: false}
    })
    .when('/login', {
      templateUrl: 'pages/login.html',
      controller: 'loginController',
      access: {restricted: false}
    })
});

myApp.run(function ($rootScope, $location, $route, AuthService) {
  $rootScope.$on('$routeChangeStart',
    function (event, next, current) {
      AuthService.getUserStatus();
      if (next.access.restricted &&
          !AuthService.isLoggedIn()) {
        $location.path('/login');
        $route.reload();
      }
  });
});