window.app = angular.module 'songbooks', ['ngRoute', 'LocalStorageModule']

app.config (localStorageServiceProvider) ->
  localStorageServiceProvider.setPrefix('songbooks')