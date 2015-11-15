(function() {
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

}).call(this);
