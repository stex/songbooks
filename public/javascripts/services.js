(function() {
  app.service('songService', [
    '$http', function($http) {
      this.activeSong = null;
      this.songs = [];
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
            return _this.songs = response.data;
          };
        })(this));
      };
      return this;
    }
  ]);

}).call(this);
