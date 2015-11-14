(function() {
  var app;

  app = angular.module('songbooks', ['ngRoute']);

  app.config([
    '$routeProvider', function($routeProvider) {
      return $routeProvider.when('/songs/:songIdentifier', {
        title: 'Song',
        templateUrl: 'static/songs/show',
        controller: 'SongController as songCtrl'
      }).otherwise({
        redirectTo: '/'
      });
    }
  ]);

  app.filter('spaceToNbsp', function() {
    return function(input) {
      return input.replace(/[ ]/g, '\u00a0');
    };
  });

  app.controller('SongsController', [
    '$http', '$routeParams', function($http, $routeParams) {
      this.songs = [];
      this.activeSong = null;
      this.setActive = function(song) {
        return this.activeSong = song;
      };
      $http.get('/songs.json').success((function(_this) {
        return function(response) {
          return _this.songs = response.data;
        };
      })(this));
      return this;
    }
  ]);

  app.controller('SongController', [
    '$http', '$routeParams', function($http, $routeParams) {
      this.song = null;
      $http.get("/songs/" + $routeParams.songIdentifier + ".json").success((function(_this) {
        return function(response) {
          return _this.song = response.data;
        };
      })(this));
      return this;
    }
  ]);

  app.directive('chord', function() {
    return {
      restrict: 'E',
      templateUrl: 'static/songs/chord',
      link: function(scope, element, attrs) {
        $(element).attr('data-name', scope.component.name);
        return $(element).attr('data-transposed-by', scope.component.transposed_by);
      }
    };
  });

  app.directive('literal', function() {
    return {
      restrict: 'E',
      templateUrl: 'static/songs/literal'
    };
  });

  app.directive('songComponent', function() {
    return {
      restrict: 'E',
      templateUrl: 'static/songs/component'
    };
  });

  console.log('initialized');

}).call(this);
