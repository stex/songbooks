(function() {
  app.service('songService', [
    '$http', 'localStorageService', function($http, localStorageService) {
      this.activeSong = null;
      this.songs = [];
      this.selectedSongs = [];
      this.songbookTitle = 'Songbook';
      this.addSongToBook = function(song) {
        if (!this.songInCollection(song, this.selectedSongs)) {
          this.selectedSongs.push(song);
        }
        return this.persistSongbook();
      };
      this.addAllToBook = function() {
        angular.forEach(this.songs, (function(_this) {
          return function(song) {
            if (!_this.songInCollection(song, _this.selectedSongs)) {
              return _this.selectedSongs.push(song);
            }
          };
        })(this));
        return this.persistSongbook();
      };
      this.removeSongFromBook = function(song) {
        var idx;
        if ((idx = this.songPositionInCollection(song, this.selectedSongs)) > -1) {
          this.selectedSongs.splice(idx, 1);
          return this.persistSongbook();
        }
      };
      this.setActiveSong = function(identifier) {
        var i, len, ref, results, song;
        ref = this.songs;
        results = [];
        for (i = 0, len = ref.length; i < len; i++) {
          song = ref[i];
          if (song.identifier === identifier) {
            if (this.activeSong) {
              this.activeSong.active = false;
            }
            this.activeSong = song;
            song.active = true;
            break;
          } else {
            results.push(void 0);
          }
        }
        return results;
      };
      this.loadSong = function(identifier) {
        return $http.get("/songs/" + identifier + ".json").success((function(_this) {
          return function(response) {
            _this.setActiveSong(identifier);
            return _this.activeSong.sections = response.data.sections;
          };
        })(this));
      };
      this.loadSongs = function() {
        return $http.get('/songs.json').success((function(_this) {
          return function(response) {
            _this.songs = response.data;
            return _this.restoreSongbook();
          };
        })(this));
      };
      this.songInCollection = function(song, collection) {
        return this.songPositionInCollection(song, collection) > -1;
      };
      this.songPositionInCollection = function(song, collection) {
        var result;
        result = -1;
        angular.forEach(collection, function(s, idx) {
          if (s.identifier === song.identifier) {
            return result = idx;
          }
        });
        return result;
      };
      this.restoreSongbook = function() {
        var storedBook;
        if ((storedBook = localStorageService.get('songbook'))) {
          this.songbookTitle = storedBook.title;
          return angular.forEach(storedBook.songs, (function(_this) {
            return function(song) {
              if (_this.songInCollection(song, _this.songs)) {
                return _this.selectedSongs.push(song);
              }
            };
          })(this));
        }
      };
      this.persistSongbook = function() {
        return localStorageService.set('songbook', {
          'songs': this.selectedSongs,
          'title': this.songbookTitle
        });
      };
      this.clearSongbook = function() {
        this.selectedSongs = [];
        this.songbookTitle = 'Songbook';
        return localStorageService.remove('songbook');
      };
      return this;
    }
  ]);

}).call(this);
