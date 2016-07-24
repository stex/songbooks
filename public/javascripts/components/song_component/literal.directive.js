(function() {
  app.directive('literal', function() {
    return {
      restrict: 'E',
      template: '{{ component.content | convertWhitespace }}'
    };
  });

}).call(this);
