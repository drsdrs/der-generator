define ["audiolib"], ->
  (myPlugin = ->
    initPlugin = (audioLib) ->
      ((audioLib) ->
        BassDrum = (sampleRate) ->
          @sampleRate = (if isNaN(sampleRate) then @sampleRate else sampleRate)

          @oscA = audioLib.Oscillator(@sampleRate, @frequency)
          @oscB = audioLib.Oscillator(@sampleRate, @frequency)

          @freqLineA = audioLib.ThreePoint(@sampleRate)
          @freqLineB = audioLib.ThreePoint(@sampleRate)

          @oscA.waveShape = "triangle"
          @oscB.waveShape = "sawtooth"
          @oscA.pulseWidth = 0.1
          @oscB.pulseWidth = 0.5

          @vol = 0
          @totalVol = 0.7

        BassDrum:: =
          sampleRate: 44100
          startFreq: 500
          endFreq: 0


          getMix: (ch) -> (
              @oscA.getMix(ch)+
              @oscB.getMix(ch)
            )*@vol/2*@totalVol

          generate: ->
            @oscA.generate()
            @oscB.generate()
            @freqLineA.generate()
            @freqLineB.generate()
            #@oscB.pulseWidth = if @oscB.pulseWidth>1 then 0 else @oscB.pulseWidth+=0.000002

            @oscA.frequency = (@startFreq-@endFreq)*@freqLineA.getMix()+@endFreq
            @oscB.frequency = (@startFreq-@endFreq)*@freqLineB.getMix()+@endFreq

          setWaveOscA: (shape) -> @oscA.waveShape = shape
          setWaveOscB: (shape) -> @oscB.waveShape = shape
          

          trigger: (vol)->
            @vol = vol
            @freqLineA.reset()
            @freqLineB.reset()

        audioLib.generators "BassDrum", BassDrum
        audioLib.BassDrum = audioLib.generators.BassDrum
      ) audioLib
      audioLib.plugins "BassDrum", myPlugin
    if typeof audioLib is "undefined" and typeof exports isnt "undefined"
      exports.init = initPlugin
    else
      initPlugin audioLib
  )()