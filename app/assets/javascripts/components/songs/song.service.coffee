app.service 'songService', ['$http', 'localStorageService', ($http, localStorageService) ->
  @activeSong = null
  @songs = []
  @selectedSongs = []
  @songbookTitle = 'Songbook'

  #
  # Adds the given song to the current songbook collection
  # This is only done in the browser and won't be submitted to the server
  # until a PDF is requested
  #
  @addSongToBook = (song) ->
    @selectedSongs.push(song) unless @songInCollection(song, @selectedSongs)
    @persistSongbook()

  #
  # Adds all currently available songs to the songbook
  #
  @addAllToBook = () ->
    angular.forEach @songs, (song) =>
      @selectedSongs.push(song) unless @songInCollection(song, @selectedSongs)
    @persistSongbook()

  #
  # Removes the given song from the current songbook collection
  # This is only done in the browser and won't be submitted to the server
  # until a PDF is requested
  #
  @removeSongFromBook = (song) ->
    if (idx = @songPositionInCollection(song, @selectedSongs)) > -1
      @selectedSongs.splice(idx, 1)
      @persistSongbook()

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
      @restoreSongbook()

  #
  # @return [Boolean] +true+ if the song is part of the given collection
  #
  @songInCollection = (song, collection) ->
    @songPositionInCollection(song, collection) > -1

  #
  # @return [Integer] the array index of the given song within the given collection
  #   or -1 if the song is not a part of it.
  #
  @songPositionInCollection = (song, collection) ->
    result = -1
    angular.forEach collection, (s, idx) ->
      result = idx if s.identifier == song.identifier
    result

  #
  # Loads a previously created songbook from the browser's local storage
  #
  @restoreSongbook = () ->
    if (storedBook = localStorageService.get('songbook'))
      @songbookTitle = storedBook.title
      angular.forEach storedBook.songs, (song) =>
        @selectedSongs.push(song) if @songInCollection(song, @songs)

  #
  # Saves the current songbook in the browser's local storage
  #
  @persistSongbook = () ->
    localStorageService.set 'songbook',
      'songs': @selectedSongs
      'title': @songbookTitle

  #
  # Clears the local songbook
  # This is only done in the browser and won't be submitted to the server
  # until a PDF is requested
  #
  @clearSongbook = () ->
    @selectedSongs = []
    @songbookTitle = 'Songbook'
    localStorageService.remove('songbook')

  @
]
