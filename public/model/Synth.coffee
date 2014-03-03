define ['underscore'], (_) ->

  class Synth
    constructor: (@name)->
      @name= @name || "Neuer Synth"+ ~~(Math.random()*1024<<6)
      @pos= 0
      @id= Date.now() * ~~(Math.random()*1000)

