app.controller 'SongsController', ['$http', 'songService', '$location', ($http, songService, $location) ->
  songService.loadSongs()

  @filterQuery = ''

  @songs = () ->
    songService.songs

  @setActive = (song) ->
    $location.path("/songs/#{song.identifier}")

  @activeSong = () ->
    songService.activeSong

  @addAllToBook = () ->
    songService.addAllToBook()

  @
]

app.controller 'SongController', ['$routeParams', 'songService', ($routeParams, songService) ->
  songService.loadSong($routeParams.songIdentifier)

  @song = () ->
    songService.activeSong

  @
]
