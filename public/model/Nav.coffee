define ['underscore'], (_) ->

  class Nav
    constructor: (@name, @link)->
      @name = @name || "Neuer link"
      @link = @link || "link target"

