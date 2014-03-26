define [], ->
  (myPlugin = ->
    initPlugin = (audioLib) ->
      ((audioLib) ->
        Synth1 = (sampleRate, frequency, detune, vol) ->
          @sampleRate = (if isNaN(sampleRate) then @sampleRate else sampleRate)
          @frequency = (if isNaN(frequency) then @frequency else frequency)
          @detune = (if isNaN(frequency) then @detune else detune)
          @vol = vol or 1
          @volA = 0.7
          @volB = 0.7
          @volC = 0.7
          @mixAmp = 0.7
          @mixPitch = 0.7
          @mixPhase = 0.7
          @oscA = audioLib.Oscillator(@sampleRate, @frequency)
          @oscB = audioLib.Oscillator(@sampleRate, @frequency - @detune)
          @oscC = audioLib.Oscillator(@sampleRate, @frequency + @detune)
          @oscPhase = audioLib.Oscillator(@sampleRate, @frequency/(1023<<1))
          @oscAmp = audioLib.Oscillator(@sampleRate, @frequency)
          @oscPitch = audioLib.Oscillator(@sampleRate, @frequency/(256))
          @oscA.waveShape = "sine"
          @oscB.waveShape = "triangle"
          @oscC.waveShape = "sine"
          @oscPhase.waveShape = "triangle"
          @oscAmp.waveShape = "sawtooth"
          @oscPitch.waveShape = "sine"

        Synth1:: =
          oscA: null
          oscB: null
          oscC: null
          sampleRate: 44100
          frequency: 240
          detune: 44

          getMix: (ch) ->
            (
              @oscA.getMix(ch)*@volA+
              @oscB.getMix(ch)*@volB+
              @oscC.getMix(ch)*@volC
            )*@vol

          generate: ->
            @oscA.generate()
            @oscB.generate()
            @oscC.generate()
            @oscPhase.generate()
            @oscAmp.generate()
            @oscPitch.generate()

            @oscA.pulseWidth = 0.5 + (@oscPhase.getMix()/2+0.5)*@mixPhase

            pitchMod = 1+@oscPitch.getMix()*@mixPitch

            @oscA.frequency = @frequency * pitchMod
            @oscB.frequency = (@frequency - @detune) * pitchMod
            @oscC.frequency = (@frequency + @detune) * pitchMod

          setVol: (vol) -> @vol = vol
          setVolA: (vol) -> @volA = vol
          setVolB: (vol) -> @volB = vol
          setVolC: (vol) -> @volC = vol

          setWaveOscA: (shape) -> @oscA.waveShape = shape
          setWaveOscB: (shape) -> @oscB.waveShape = shape
          setWaveOscC: (shape) -> @oscC.waveShape = shape

          setWaveOscPhase: (shape) -> @oscPhase.waveShape = shape
          setWaveOscAmp: (shape) -> @oscAmp.waveShape = shape
          setWaveOscPitch: (shape) -> @oscPitch.waveShape = shape

          setFreqOscPitch: (freq) -> @oscPitch.frequency = freq
          setFreqOscAmp: (freq) -> @oscAmp.frequency = freq
          setFreqOscPhase: (freq) -> @oscPhase.frequency = freq

          setMixPitch: (mix) -> @mixPitch = mix
          setMixAmp: (mix) -> @mixAmp = mix
          setMixPhase: (mix) -> @mixPhase = mix

          setFreq: (freq) ->
            @frequency = freq
            @oscA.frequency = freq
            @oscB.frequency = freq - @detune
            @oscC.frequency = freq + @detune
            @resetAll()

          setDetune: (detune) ->
            @detune = detune
            @oscA.frequency = @frequency
            @oscB.frequency = @frequency - detune
            @oscC.frequency = @frequency + detune

          #trigger: -> @resetAll()
          resetAll: ->
            @oscAmp.reset()
            @oscPhase.reset()
            @oscPitch.reset()
            @oscA.reset()
            @oscB.reset()
            @oscC.reset()


        audioLib.generators "Synth1", Synth1
        audioLib.Synth1 = audioLib.generators.Synth1
      ) audioLib
      audioLib.plugins "Synth1", myPlugin
    if typeof audioLib is "undefined" and typeof exports isnt "undefined"
      exports.init = initPlugin
    else
      initPlugin audioLib
  )()