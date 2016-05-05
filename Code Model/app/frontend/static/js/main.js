/**
 * Created by Erikka on 4/7/2016.
 * View - routing
 */


/**
 *Main Module of The Application
 */

var myApp = angular.module('myApp', ['ui.router']);

myApp.config(function ($stateProvider, $urlRouterProvider) {

    $urlRouterProvider.otherwise('/dashboard');

    $stateProvider
        .state('base', {
            abstract: true,
            url: '',
            templateUrl: 'pages/base.html'
        })

        /*Authentication*/
        .state('login', {
            url: '/login',
            templateUrl: 'pages/login.html',
            controller: 'loginController'
        })

        .state('dashboard', {
            url: '/dashboard',
            parent: 'base',
            templateUrl: 'pages/dashboard.html',
            controller: 'loginController'
        })
        
        .state('assessment-add', {
            url: '/dashboard',
            templateUrl: 'pages/nurse/assessment.html',
            controller: 'loginController'
        })
});