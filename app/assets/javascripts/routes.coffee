app.config ['$routeProvider', ($routeProvider) ->
  $routeProvider
  .when '/songs/:songIdentifier',
    title: 'Song',
    templateUrl: 'static/songs/show'
    controller: 'SongController as songCtrl'
  .otherwise
      redirectTo: '/'
]