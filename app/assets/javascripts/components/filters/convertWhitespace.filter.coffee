app.filter 'convertWhitespace', () ->
  (text) ->
    text.replace /[ ]/g, '\u00a0'
