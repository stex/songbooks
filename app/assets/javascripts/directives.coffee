app.directive 'song', () ->
  {
    restrict: 'E',
    templateUrl: 'static/songs/song'
  }

app.directive 'chord', () ->
  {
  restrict: 'E',
  templateUrl: 'static/songs/chord',
  link: (scope, element, attrs) ->
    $(element).attr('data-name', scope.component.name)
    $(element).attr('data-transposed-by', scope.component.transposed_by)
  }

app.directive 'literal', () ->
  {
  restrict: 'E',
  templateUrl: 'static/songs/literal'
  }

app.directive 'songComponent', () ->
  {
  restrict: 'E',
  templateUrl: 'static/songs/component'
  }