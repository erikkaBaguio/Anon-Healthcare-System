/**
 * Created by Erikka on 4/7/2016.
 */

var myApp = angular.module("myApp",['ngRoute']);

myApp.config(function ($routeProvider) {
    $routeProvider
    .when('/', {
      templateUrl: 'static/index.html',
      access: {restricted: true}
    })
    .when('/login', {
      templateUrl: 'static/pages/login.html',
      controller: 'loginController',
      access: {restricted: false}
    })
});