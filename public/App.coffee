
window.c=console;c.l=c.log

define (require)->
  #load lib's
  app = {}
  window.app = app
  $ = require 'jquery'
  _ = require 'underscore'
  d3 = require 'd3'
  audiolib = require 'audiolib'
  ls = require 'cs!./LocalStorage'

  instrumentNames = ['mixer', 'BassDrum', 'snare', 'clap', 'hihatOpen', 'hihatClosed'
    'tomHigh', 'tomMid', 'tomLow', 'bassSynth', 'leadSynth', 'fxSynth']
  instrumentNames = ['Snare','KickDrum','BassDrum']

  #load d3 plugins
  lineInputD3 = require 'cs!./inputPlugins/lineInputD3/lineInputD3'
  faderInputD3 = require 'cs!./inputPlugins/faderInputD3/faderInputD3'
  rotaryInputD3 = require 'cs!./inputPlugins/rotaryInputD3/rotaryInputD3'
  seqInput = require 'cs!./inputPlugins/seqInput/seqInput'
  btnInput = require 'cs!./inputPlugins/btnInput/btnInput'

  #load stylesheets
  require 'less!./style'
  require 'less!./inputPlugins/lineInputD3/lineInputD3'
  require 'less!./inputPlugins/faderInputD3/faderInputD3'
  require 'less!./inputPlugins/seqInput/seqInput'
  require 'less!./inputPlugins/btnInput/btnInput'

  #load waveform visual
  CanvasVisual = require 'cs!./view/CanvasVisual'
  cv = new CanvasVisual("canvasVisual")

  #load general audioLib plugins
  require 'cs!./instrumentPlugins/ThreePoint.coffee'
  require 'cs!./instrumentPlugins/LoopSequencer'

  # load instrument plugins
  require 'cs!./instrumentPlugins/BassDrum'
  require 'cs!./instrumentPlugins/KickDrum'
  require 'cs!./instrumentPlugins/Snare'

  #load instrument templates
  tpl = {}
  tpl.BassDrum = require 'text!./templates/BassDrum.html'
  tpl.KickDrum = require 'text!./templates/KickDrum.html'
  tpl.Snare = require 'text!./templates/Snare.html'



  app.ls = ls
  app.cv = cv
  cfg = ls.load()
  app.cfg = cfg

  #app.cfg = "{"main":{"bpm":120,"autoPilot":{"state":false}},"mixer":{"BassDrum":75,"snare":75,"clap":75,"hihatOpen":75,"hihatClosed":75,"tomHigh":75,"tomMid":75,"tomLow":75,"bassSynth":75,"leadSynth":75,"fxSynth":75},"synths":{"BassDrum":{"startFreq":456.19047619047615,"endFreq":0,"freqLineA":{"y1":1,"x2":0.13666666666666666,"y2":0.11833333333333329,"y3":0,"length":0.7983333333333333},"freqLineB":{"y1":1,"x2":0.13010416666666666,"y2":0.10833333333333328,"y3":0,"length":0.7783333333333333},"volLine":{"attack":1000,"decay":500,"release":550},"sequencer":[[0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0],[1,2,3,1,0,0,0,0]],"oscA":{"waveShape":"sine"}},"Snare":{"lpFilter":{"cutoff":4000,"resonance":1},"freqCurveA":0.0007283333333333333,"freqCurveB":0.0002491666666666667,"delay":null,"startFreqA":3841.2698412698414,"startFreqB":6768.253968253968,"sequencer":[[0,0,0,0],[0,0,0,0],[0,0,0,0],[1,2,3,1]],"oscA":{"waveShape":"sine"},"oscB":{"color":"white"}},"clap":{},"hihatOpen":{},"hihatClosed":{},"tomHigh":{},"tomMid":{},"tomLow":{},"bassSynth":{},"leadSynth":{},"fxSynth":{}}}"


  initSynth= ()->
    if app.dev? then app.dev.kill()
    #fxs = @model.fxs

    dev = new audioLib.Sink()
    seq = new audioLib.LoopSequencer(dev.sampleRate)
    osc = {}
    osc.BassDrum = new audioLib.BassDrum(dev.sampleRate)
    osc.KickDrum = new audioLib.KickDrum(dev.sampleRate)
    osc.Snare = new audioLib.Snare(dev.sampleRate)

    seq.length = 1
    seq.tempo = 60

    seq.kill = ->
      #seq.getMix = null
      #seq.ongenerate = null
      seq = null
      sequence = []
      cv.clear()

    seq.getMix = (ch) ->
      osc.BassDrum.getMix()+
      osc.KickDrum.getMix()+
      osc.Snare.getMix()

    seq.ongenerate = ->
      osc.BassDrum.generate()
      osc.KickDrum.generate()
      osc.Snare.generate()


    dev.on "audioprocess", (buffer, channelCount) ->
      cv.clear()
      seq.append buffer, channelCount
      cv.draw buffer, channelCount, "rgba(128,255,128, 0.9)"

    app.seq = seq
    app.osc = osc


  renderInstrument = (name, tpl, cfg) ->
    _.templateSettings.variable = "cfg"
    template = _.template(tpl)(cfg)
    $("body").append template

    #init gui input plugins
    lineInputD3 $("#"+name+" .lineInputD3"), cfg, app.osc[name]
    faderInputD3 $("#"+name+" .faderInputD3"), cfg, app.osc[name]
    rotaryInputD3 $("#"+name+" .rotaryInputD3"), cfg, app.osc[name]
    seqInput $("#"+name+" .seqInput"), cfg, app.seq, app.osc[name]
    btnInput $("#"+name+" .btnInput"), cfg, app.osc[name]

  #load instruments
  loadInstruments = () ->
    len = 0
    instruments = {}
    while len<instrumentNames.length
      cfg = app.cfg.synths[instrumentNames[len]]
      renderInstrument instrumentNames[len], tpl[instrumentNames[len]], cfg
      len++

  $(".toggleInstr").click (e)->
    $(@).toggleClass("turn-180")
    target = $("#"+e.target.parentElement.parentElement.id)
    target = target.children().not("h3")
    if $(@).hasClass("turn-180")
      target.slideUp("100")
    else
      target.slideDown("100")

  # loc = window.location.hostname
  # socket = io.connect("http://" + loc)
  # socket.on "serverMessage", (data) ->
  #   socket.emit "clientEvent",
  #     my: "data"

  c.l "cfg OK? ...", ls.load()==app.cfg
  initSynth()
  loadInstruments()

  # bands to download
  #-------------------
  #   Kap Bambino
  #   ADULT
  #