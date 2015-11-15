(function() {
  app.config([
    '$routeProvider', function($routeProvider) {
      return $routeProvider.when('/songs/:songIdentifier', {
        title: 'Song',
        templateUrl: 'static/songs/show',
        controller: 'SongController as songCtrl'
      }).when('/', {
        template: 'Choose a song on the left'
      }).otherwise({
        redirectTo: '/'
      });
    }
  ]);

}).call(this);
