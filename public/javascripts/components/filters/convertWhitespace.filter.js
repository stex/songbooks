(function() {
  app.filter('convertWhitespace', function() {
    return function(text) {
      return text.replace(/[ ]/g, '\u00a0');
    };
  });

}).call(this);
