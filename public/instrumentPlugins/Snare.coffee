define ["audiolib"], ->
  (myPlugin = ->
    initPlugin = (audioLib) ->
      ((audioLib) ->
        Snare = (sampleRate) ->
          @sampleRate = (if isNaN(sampleRate) then @sampleRate else sampleRate)

          @oscA = audioLib.Oscillator(@sampleRate, 0)
          @oscB = audioLib.Noise(@sampleRate, 0)
          @lpFilter = audioLib.LP12Filter(@sampleRate, 50, 1);
          @delay = new audioLib.Delay(sampleRate, 333, 666, 999);
          @oscA.frequency = 0
          @oscB.frequency = 0
          @vol = 0
          @totalVol = 0.7


          @oscA.waveShape = "triangle"
          @oscB.color = "brown"
          @oscA.pulseWidth = 0.5

        Snare:: =
          sampleRate: 44100
          freqCurveA: 0
          freqCurveB: 0
          startFreqA: 0
          startFreqB: 0


          getMix: (ch) ->
            smpl = (@oscA.getMix(ch)+@oscB.getMix(ch))/2
            @lpFilter.pushSample(smpl)
            @delay.pushSample(@lpFilter.getMix(ch), ch)
            @delay.getMix(ch)*@vol*@totalVol


          generate: -> 
              @oscA.generate()
              @oscB.generate()
              @oscA.frequency = @oscA.frequency/(1+@freqCurveA)
              @lpFilter.cutoff = @lpFilter.cutoff/(1+@freqCurveB)

            #if @oscA.frequency<0.00001
              #@resetAll()

          

          trigger: (vol)-> 
            @oscA.frequency = @startFreqA
            @lpFilter.cutoff = @startFreqB
            @vol = vol

        audioLib.generators "Snare", Snare
        audioLib.Snare = audioLib.generators.Snare
      ) audioLib
      audioLib.plugins "Snare", myPlugin
    if typeof audioLib is "undefined" and typeof exports isnt "undefined"
      exports.init = initPlugin
    else
      initPlugin audioLib
  )()