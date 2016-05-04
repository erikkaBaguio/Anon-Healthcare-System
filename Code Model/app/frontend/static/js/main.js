/**
 * Created by Erikka on 4/7/2016.
 * View - routing
 */

var myApp = angular.module("myApp", ["ngRoute"]);

myApp.config(function ($routeProvider) {
    $routeProvider
    .when('/', {
      templateUrl: 'pages/doctor/dashboard-doctor.html',
      controller: 'dashboardController',
      access: {restricted: false}
    })
    .when('/dashboard',{
        templateUrl: 'pages/dashboard-nurse.html',
        access: {restricted:true}
    })
    .when('/logout', {
        controller: 'logoutController',
    })
    .otherwise({
      redirectTo: '/'
    });
});

// Change of state
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