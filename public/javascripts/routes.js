(function() {
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

}).call(this);
