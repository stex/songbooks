(function() {
  app.controller('SongbookController', [
    '$http', 'songService', function($http, songService) {
      this.filterQuery = '';
      this.songs = function() {
        return songService.selectedSongs;
      };
      this.title = function() {
        return songService.songbookTitle;
      };
      this.addSong = function(song) {
        return songService.addSongToBook(song);
      };
      this.removeSong = function(song) {
        return songService.removeSongFromBook(song);
      };
      this.clear = function() {
        return songService.clearSongbook();
      };
      this.sendToServer = function() {
        return $http.post('/songbook', {
          'songs': this.songs().map(function(s) {
            return s.identifier;
          })
        }).success(function() {
          return window.location.href = '/songbook.pdf';
        });
      };
      return this;
    }
  ]);

}).call(this);
