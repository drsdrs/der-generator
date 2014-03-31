define [], ->
	(myPlugin = ->
	  initPlugin = (audioLib) ->
	    ((audioLib) ->
	      LoopSequencer = (sampleRate, tempo, length) ->
	        @sampleRate = (if isNaN(sampleRate) or sampleRate is null then @sampleRate else sampleRate)
	        @tempo = (if isNaN(tempo) or tempo is null then @tempo else tempo)
	        @length = (if isNaN(length) or length is null then @length else length)
	        @sequence = []
	        return
	      LoopSequencer:: =
	        sampleRate: 44100
	        position: 0
	        length: 4
	        tempo: 120
	        samples: null
	        sequence: null
	        generate: ->
	          lastPos = @position
	          seq = @sequence
	          pos = undefined
	          i = undefined
	          e = undefined
	          @position = pos = (lastPos + 60 / @tempo / @sampleRate) % @length
	          i = 0
	          while i < seq.length
	            e = seq[i]
	            e.c.call this  if (lastPos > pos and (e.t >= lastPos or pos > e.t)) or (lastPos <= e.t and pos > e.t)
	            i++
	          @ongenerate and @ongenerate.apply(this, arguments)
	          return

	        getMix: ->
	          0

	        addEvent: (time, callback, functi, param1, param2) ->
	          e =
	            c: ->
	              callback[functi] param1, param2
	              return

	            t: time

	          @sequence.push e
	          return e

	        removeEvent: (e) ->
	          i = undefined
	          i = 0
	          while i < @sequence.length
	            @sequence[i] is e and @sequence.splice(i--, 1)
	            i++
	          return

	      audioLib.generators "LoopSequencer", LoopSequencer
	      audioLib.LoopSequencer = audioLib.generators.LoopSequencer
	      return
	    ) audioLib
	    audioLib.plugins "LoopSequencer", myPlugin
	    return
	  if typeof audioLib is "undefined" and typeof exports isnt "undefined"
	    exports.init = initPlugin
	  else
	    initPlugin audioLib
	  return
	)()