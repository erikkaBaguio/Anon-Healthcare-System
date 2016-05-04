/**
 * Created by Erikka on 4/7/2016.
 * View - routing
 */


/*Main Module*/
var myApp = angular.module("myApp", ['ngRoute', 'ngResource']);

myApp.config(function ($routeProvider, $resourceProvider, $locationProvider) {

    $routeProvider

        /*Authentication*/
        .when('/login',{
            templateUrl: 'pages/login.html',
            controller: 'dashboardController'
        })

        .when('/logout', {
            controller: 'logoutController'
        })

        /*Assessment*/
        .when('/dashboard',{
            templateUrl: 'pages/nurse/dashboard-nurse.html',
            controller: 'dashboardController'
        })

        .when('/dashboard/assessments/add',{
            templateUrl: 'pages/nurse/assessment_form.html',
            controller: 'assessmentController'
        })

        .when('/dashboard/assessments/:id',{
            templateUrl: 'pages/nurse/assessment.html',
            controller: 'assessmentController'
        })

        .when('/dashboard/assessments',{
            templateUrl: 'pages/nurse/list_of_assessments.html',
            controller: 'assessmentController'
        })

        .when('/dashboard/assessments/:id',{
            templateUrl: 'pages/nurse/list_of_assessments.html',
            controller: 'assessmentController'
        })

        /*Patients*/
        .when('/dashboard/patients/add',{
            templateUrl: 'pages/nurse/add_patient_form.html',
            controller: 'patientsController'
        })

        .when('/dashboard/patients',{
            templateUrl: 'pages/nurse/dashboard-nurse.html',
            controller: 'patientsController'
        })

        .when('/dashboard/patients/:id',{
            templateUrl: 'pages/nurse/dashboard-nurse.html',
            controller: 'patientsController'
        })

        .otherwise({
          redirectTo: '/dashboard'
        });

    $resourceProvider.defaults.stripTrailingSlashes = false;
});

// Change of state
// myApp.run(function ($rootScope, $location, $route, AuthService) {
//   $rootScope.$on('$routeChangeStart',
//     function (event, next, current) {
//       AuthService.getUserStatus();
//       if (next.access.restricted &&
//           !AuthService.isLoggedIn()) {
//         $location.path('/login');
//         $route.reload();
//       }
//   });
// });