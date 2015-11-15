(function() {
  app.filter('spaceToNbsp', function() {
    return function(input) {
      return input.replace(/[ ]/g, '\u00a0');
    };
  });

}).call(this);
