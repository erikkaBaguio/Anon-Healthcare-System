/**
 * Created by Erikka on 4/7/2016.
 * View - routing
 */


/**
 *Main Module of The Application
 */

var myApp = angular.module('myApp', ['ui.router']);

myApp.config(function ($stateProvider, $urlRouterProvider) {

    $urlRouterProvider.otherwise('/login');

    $stateProvider

    /*Authentication*/
        .state('login', {
            url: '/login',
            templateUrl: 'pages/login.html',
            controller: 'loginController'
        })

        .state('dashboard', {
            url: '/dashboard',
            views: {
                '': {
                    templateUrl: 'pages/dashboard.html',
                    controller: 'NavigationController'
                },
                'dashboard@dashboard': {
                    templateUrl: 'pages/content/dashboard.html'
                },
            }
        })

        .state('dashboard.assessment-add', {
            url: '/assessments/add ',
            templateUrl: 'pages/content/assessment.html'
        })
});