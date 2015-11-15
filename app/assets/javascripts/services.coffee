app.service 'songService', ['$http', ($http) ->
  @activeSong = null
  @songs = []

  @setActiveSong = (identifier) ->
    for song in @songs
      if song.identifier == identifier
        @activeSong.active = false if @activeSong
        @activeSong = song
        song.active = true
        break

  @loadSong = (identifier) ->
    $http.get("/songs/#{identifier}.json").success (response) =>
      @setActiveSong(identifier)
      @activeSong.sections = response.data.sections

  @loadSongs = () ->
    $http.get('/songs.json').success (response) =>
      @songs = response.data

  @
]