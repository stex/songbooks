(function() {
  app.controller('SongsController', [
    '$http', 'songService', '$location', function($http, songService, $location) {
      songService.loadSongs();
      this.filterQuery = '';
      this.songs = function() {
        return songService.songs;
      };
      this.setActive = function(song) {
        return $location.path("/songs/" + song.identifier);
      };
      this.activeSong = function() {
        return songService.activeSong;
      };
      this.addAllToBook = function() {
        return songService.addAllToBook();
      };
      return this;
    }
  ]);

}).call(this);
