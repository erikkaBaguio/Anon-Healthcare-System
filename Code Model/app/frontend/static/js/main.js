/**
 * Created by Erikka on 4/7/2016.
 * View - routing
 */


/**
 *Main Module of The Application
 */

var myApp = angular.module("myApp", ['ui.router', 'ngResource']);

myApp.config(function ($stateProvider, $urlRouterProvider) {

    $urlRouterProvider.when('/dashboard');
    $urlRouterProvider.otherwise('/login');

    $stateProvider
        .state('base', {
            abstract: true,
            url: '',
            templateUrl: ''
        })

        /*Authentication*/
        .state('login', {
            url: '/login',
            parent: 'base',
            templateUrl: 'pages/login.html',
            controller: 'loginController'
        })

        .state('dashboard', {
          url: '/dashboard',
          parent: 'base',
          templateUrl: 'pages/dashboard.html',
          controller: 'DashboardCtrl'
        })
});