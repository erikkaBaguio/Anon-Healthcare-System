var myApp = angular.module('myApp', []);
//ng-route
//$http
//integrating flask and api.

myApp.controller("MainController", ['$scope', function($scope){
    var products = ['1', '2'];
    $scope.products = products;
}]);