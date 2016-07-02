app.controller 'SongbookController', ['$http', 'songService', ($http, songService) ->
  @filterQuery = ''

  @songs = () ->
    songService.selectedSongs

  @title = () ->
    songService.songbookTitle

  @addSong = (song) ->
    songService.addSongToBook(song)

  @removeSong = (song) ->
    songService.removeSongFromBook(song)

  @clear = () ->
    songService.clearSongbook()

  @sendToServer = () ->
    $http.post '/songbook',
      'songs': @songs().map (s) ->
        s.identifier
    .success ->
      window.location.href = '/songbook.pdf'

  @
]
