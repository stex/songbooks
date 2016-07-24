(function() {
  app.directive('song', function() {
    return {
      restrict: 'E',
      templateUrl: 'static/songs/song'
    };
  });

}).call(this);
