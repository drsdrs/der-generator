define ["audiolib"], ->
  (myPlugin = ->
    initPlugin = (audioLib) ->
      ((audioLib) ->
        ThreePoint = (sampleRate, y1, x2, y2, y3, length) -> # length in sec
          @sampleRate = (if isNaN(sampleRate) then @sampleRate else sampleRate)
          @y1 = (if isNaN(y1) then @y1 else y1)
          @x2 = (if isNaN(x2) then @x2 else x2)
          @y2 = (if isNaN(y2) then @y2 else y2)
          @y3 = (if isNaN(y3) then @y3 else y3)
          @length = (if isNaN(length) then @length else length)


        ThreePoint:: =
          sampleRate: 44100
          y1: 1
          x2: 0.3
          y2: 0.3
          y3: 0
          length: 0.1
          
          sample: 0
          t:0
          
          generate: ->
            lengthReal = @length*@sampleRate
            posX = @t/lengthReal
            pointX2 = @x2*lengthReal
            if @t<pointX2 then @sample = (((@y2-@y1)/(@x2))*posX)+@y1
            else if @t<lengthReal then @sample = (((@y3-@y2)/1)*(posX-(@x2)))+@y2
            else @sample=0#; @t=0;
            #@sample = 0 if @sample is Number.POSITIVE_INFINITY or @sample is Number.NEGATIVE_INFINITY
            if @sample>1 then @sample=1
            else if @sample<-1 then @sample=-1
            @t+=0.5
            @sample

          getMix: -> @sample
          reset: -> @t = 0

        audioLib.generators "ThreePoint", ThreePoint
        audioLib.ThreePoint = audioLib.generators.ThreePoint
      ) audioLib
      audioLib.plugins "ThreePoint", myPlugin
    if typeof audioLib is "undefined" and typeof exports isnt "undefined"
      exports.init = initPlugin
    else
      initPlugin audioLib
  )()