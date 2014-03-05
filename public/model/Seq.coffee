define ['underscore'], (_) ->

  class Seq
    constructor: (@name)->
      @name = @name || "Neuer Synth"+ ~~(Math.random()*1024)
      @pos = 0
      @id = Date.now() * ~~(Math.random()*1000)
      @selSynth = false

