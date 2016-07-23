(function() {
  app.controller('SongController', [
    '$routeParams', 'songService', function($routeParams, songService) {
      songService.loadSong($routeParams.songIdentifier);
      this.song = function() {
        return songService.activeSong;
      };
      return this;
    }
  ]);

}).call(this);
