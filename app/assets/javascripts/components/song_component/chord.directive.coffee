app.directive 'chord', () ->
  {
    restrict: 'E',
    templateUrl: 'static/songs/chord',
    link: (scope, element, attrs) ->
      $(element).attr('data-name', scope.component.name)
      $(element).attr('data-transposed-by', scope.component.transposed_by)
  }
