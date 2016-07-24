app.directive 'chord', () ->
  {
    restrict: 'E',
    template: '{{ component.name }}'
    link: (scope, element) ->
      $(element).attr('data-name', scope.component.name)
      $(element).attr('data-transposed-by', scope.component.transposed_by)
  }

