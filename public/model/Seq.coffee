define ['underscore'], (_) ->

  class Seq
    constructor: (@name)->
      @name = @name || "Neuer Sequencer"
      @pos = 0
      @id = Date.now() * ~~(Math.random()*1000)
      @selDrumkit = app.collections.drumkits[0]
      @selSynth = false

      @drumGenerator =
        basicBeat:
          width: 8
          height: @selDrumkit.drums.length
          data: []

      bb = @drumGenerator.basicBeat

      j = bb.height
      while j--
        i = bb.width
        bb.data[j] = []
        while i--
          bb.data[j][i] = 0
      c.l bb
