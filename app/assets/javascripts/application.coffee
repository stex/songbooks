app = angular.module 'songbooks', ['ngRoute']

app.config ['$routeProvider', ($routeProvider) ->
  $routeProvider
  .when '/songs/:songIdentifier',
    title: 'Song',
    templateUrl: 'static/songs/show'
    controller: 'SongController as songCtrl'
  .otherwise
      redirectTo: '/'
]

app.filter 'spaceToNbsp', () ->
  (input) ->
    input.replace /[ ]/g, '\u00a0'

app.controller 'SongsController', ['$http', '$routeParams', ($http, $routeParams) ->
  @songs      = []
  @activeSong = null

  @setActive = (song) ->
    @activeSong = song

  $http.get('/songs.json').success (response) =>
    @songs = response.data

  @
]

app.controller 'SongController', ['$http', '$routeParams', ($http, $routeParams) ->
  @song = null

  $http.get("/songs/#{$routeParams.songIdentifier}.json").success (response) =>
    @song = response.data

  @
]

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
    templateUrl: 'static/songs/literal',
  }

app.directive 'songComponent', () ->
  {
  restrict: 'E',
  templateUrl: 'static/songs/component'
  }

console.log 'initialized'