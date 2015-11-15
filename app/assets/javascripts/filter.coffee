app.filter 'spaceToNbsp', () ->
  (input) ->
    input.replace /[ ]/g, '\u00a0'