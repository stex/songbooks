app.controller 'SongController', ['$routeParams', 'songService', ($routeParams, songService) ->
  songService.loadSong($routeParams.songIdentifier)

  @song = () ->
    songService.activeSong

  @
]


