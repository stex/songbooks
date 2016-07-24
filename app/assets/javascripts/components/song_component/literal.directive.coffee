app.directive 'literal', () ->
  {
    restrict: 'E',
    template: '{{ component.content | convertWhitespace }}'
  }

