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

}).call(this);
