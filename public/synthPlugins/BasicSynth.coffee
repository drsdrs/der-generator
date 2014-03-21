define [], ->
  (myPlugin = ->
    initPlugin = (audioLib) ->
      ((audioLib) ->
        BasicSynth = (sampleRate, frequency, detune, vol) ->
          @sampleRate = (if isNaN(sampleRate) then @sampleRate else sampleRate)
          @frequency = (if isNaN(frequency) then @frequency else frequency)
          @detune = (if isNaN(frequency) then @detune else detune)
          @vol = vol or 0.1
          @volA = @volB = @volC = 0
          @mixAmp = 0
          @mixPitch = 0
          @mixPhase = 0
          @oscA = audioLib.Oscillator(@sampleRate, @frequency)
          @oscB = audioLib.Oscillator(@sampleRate, @frequency/2)
          @oscA.waveShape = "sine"
          @oscB.waveShape = "triangle"
          @oscC.waveShape = "sine"


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
            )*@vol

          generate: ->
            @oscA.generate()
            @oscB.generate()
            @oscC.generate()
            @oscPhase.generate()
            @oscAmp.generate()
            @oscPitch.generate()

            @oscA.pulseWidth = (@oscPhase.getMix()/2+0.5)/@mixPhase

            @setDetune(@frequency*@oscPitch.getMix()/32)

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
            @oscPhase.reset()
            @oscA.reset()
            @oscB.reset()
            @oscC.reset()
            @oscAmp.reset()


        audioLib.generators "BasicSynth", BasicSynth
        audioLib.BasicSynth = audioLib.generators.BasicSynth
      ) audioLib
      audioLib.plugins "BasicSynth", myPlugin
    if typeof audioLib is "undefined" and typeof exports isnt "undefined"
      exports.init = initPlugin
    else
      initPlugin audioLib
  )()