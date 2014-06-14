define ["audiolib"], ->
  (myPlugin = ->
    initPlugin = (audioLib) ->
      ((audioLib) ->
        KickDrum = (sampleRate) ->
          @sampleRate = (if isNaN(sampleRate) then @sampleRate else sampleRate)

          @oscA = audioLib.Oscillator(@sampleRate, @startFreq)
          @oscB = audioLib.Oscillator(@sampleRate, @startFreq)


          @oscA.waveShape = "triangle"
          @oscB.waveShape = "sawtooth"
          @oscA.pulseWidth= 0.1
          @oscB.pulseWidth= 0.5
          @vol  = 0
          @totalVol = 0.7
        KickDrum:: =
          sampleRate: 44100
          length: 0.12 # in sec
          freqCurveA: 0.0008
          freqCurveB: 0.0004
          startFreqA: 220
          startFreqB: 220


          getMix: (ch) -> (
              @oscA.getMix(ch)+
              @oscB.getMix(ch)
            ) * @vol/2 * @totalVol

          generate: ->
            @oscA.generate()
            @oscB.generate()

            @oscA.frequency = @oscA.frequency*(1-@freqCurveA)
            @oscB.frequency = @oscB.frequency*(1-@freqCurveB)

            # if @oscA.frequency<0.1&&@oscB.frequency<0.1
              # @resetAll()


          setWaveOscA: (shape) -> @oscA.waveShape = shape
          setWaveOscB: (shape) -> @oscB.waveShape = shape
          

          trigger: (vol)->
            @vol = vol
            @oscA.frequency = @startFreqA 
            @oscB.frequency = @startFreqB


        audioLib.generators "KickDrum", KickDrum
        audioLib.KickDrum = audioLib.generators.KickDrum
      ) audioLib
      audioLib.plugins "KickDrum", myPlugin
    if typeof audioLib is "undefined" and typeof exports isnt "undefined"
      exports.init = initPlugin
    else
      initPlugin audioLib
  )()