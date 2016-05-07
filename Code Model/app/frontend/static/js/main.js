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

    /*Authentication*/
        .state('login', {
            url: '/',
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
                    templateUrl: 'pages/content/dashboard.html',
                    controller: 'NavigationController'
                },
            }
        })

        .state('dashboard.assessment-add', {
            url: '/assessments/add',
            templateUrl: 'pages/content/assessment.html'
        })
<<<<<<< HEAD
        .state('dashboard.patient-add',{
            url:'/patients/add',
            templateUrl: 'pages/content/addPatient.html'
        })
=======

        .state('dashboard.patient-search', {
            url: '/patients',
            templateUrl: 'pages/content/assessments-search.html'
        })

>>>>>>> 760d9cf795ebe91bbb86d7f3844359a79c2b416b
});