define (require) ->
  appStorageName = "generator_1010011010"
  templateData = {
    main: {
      bpm: 120
    }
    synths: {
      Mixer: {
        BassDrum:75
        snare:75
        clap:75
        hihatOpen:75
        hihatClosed:75
        tomHigh:75
        tomMid:75
        tomLow:75
        bassSynth: 75
        leadSynth: 75
        fxSynth: 75
      }
      BassDrum:{
        startFreq: 1000
        endFreq: 50
        freqLineA:{ y1:0, x2:0, y2:0, y3:0, length:0.25 }
        freqLineB:{ y1:0, x2:0, y2:0, y3:0, length:0.1 }
        volLine:{ attack:1000 }
      }
      Snare:{}
      KickDrum:{}
    }
  }
  ls = {}
  ls.load = ->
	  data = JSON.parse(localStorage.getItem(appStorageName)) || null
	  if !data? then data = templateData; c.l "load data from template"
	  data

  ls.save = (data) -> localStorage.setItem appStorageName, JSON.stringify(data)
  
  ls

