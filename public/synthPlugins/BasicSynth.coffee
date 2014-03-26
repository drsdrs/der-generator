define [], ->
  (myPlugin = ->
    initPlugin = (audioLib) ->
      ((audioLib) ->
        BasicSynth = (sampleRate, frequency, detune, vol) ->
          @sampleRate = (if isNaN(sampleRate) then @sampleRate else sampleRate)
          @frequency = (if isNaN(frequency) then @frequency else frequency)
          @detune = (if isNaN(frequency) then @detune else detune)
          @volA = @volB = 0
          @oscA = audioLib.Oscillator(@sampleRate, @frequency)
          @oscB = audioLib.Oscillator(@sampleRate, @frequency/2)


        BasicSynth:: =
          oscA: null
          oscB: null
          sampleRate: 44100
          frequency: 0
          detune: 0

          getMix: (ch) ->
            (
              @oscA.getMix(ch)*@volA+
              @oscB.getMix(ch)*@volB
            )

          generate: ->
            @oscA.generate()
            @oscB.generate()

          setVolA: (vol) -> @volA = vol
          setVolB: (vol) -> @volB = vol
          setWaveOscA: (shape) -> @oscA.waveShape = shape
          setWaveOscB: (shape) -> @oscB.waveShape = shape
          setFreq: (freq) ->
            @frequency = freq
            @oscA.frequency = freq
            @oscB.frequency = freq/2

          trigger: -> @resetAll()
          resetAll: ->
            @oscA.reset()
            @oscB.reset()

        audioLib.generators "BasicSynth", BasicSynth
        audioLib.BasicSynth = audioLib.generators.BasicSynth
      ) audioLib
      audioLib.plugins "BasicSynth", myPlugin
    if typeof audioLib is "undefined" and typeof exports isnt "undefined"
      exports.init = initPlugin
    else
      initPlugin audioLib
  )()