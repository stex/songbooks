(function() {
  window.app = angular.module('songbooks', ['ngRoute', 'LocalStorageModule']);

  app.config(function(localStorageServiceProvider) {
    return localStorageServiceProvider.setPrefix('songbooks');
  });

}).call(this);
