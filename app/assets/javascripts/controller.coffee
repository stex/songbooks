app.controller 'SongsController', ['$http', 'songService', '$location', ($http, songService, $location) ->
  songService.loadSongs()

  @songs = () ->
    songService.songs

  @setActive = (song) ->
    $location.path("/songs/#{song.identifier}")

  @
]

app.controller 'SongController', ['$routeParams', 'songService', ($routeParams, songService) ->
  songService.loadSong($routeParams.songIdentifier)

  @song = () ->
    songService.activeSong

  @
]