(function() {
  app.directive('chord', function() {
    return {
      restrict: 'E',
      template: '{{ component.name }}',
      link: function(scope, element) {
        $(element).attr('data-name', scope.component.name);
        return $(element).attr('data-transposed-by', scope.component.transposed_by);
      }
    };
  });

}).call(this);
