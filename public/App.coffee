window.c=console;c.l=c.log;c.w=c.warn

define (require)->
  $ = require 'jquery'
  _ = require 'underscore'
  d3 = require 'd3'

  Synth = require 'cs!./model/Synth'
  Drumkit = require 'cs!./model/Drumkit'
  Seq = require 'cs!./model/Seq'
  Nav = require 'cs!./model/Nav'

  synthParams =   require 'cs!./model/synthParams.coffee'
  drumkitParams = require 'cs!./model/drumkitParams.coffee'
  fxParams =      require 'cs!./model/fxParams.coffee'

  ListView =          require 'cs!./view/ListView'
  DetailView =        require 'cs!./view/DetailView'
  SynthDetailView =   require 'cs!./view/SynthDetailView'
  SeqDetailView =     require 'cs!./view/SeqDetailView'
  DrumkitDetailView = require 'cs!./view/DrumkitDetailView'
  NavView =           require 'cs!./view/NavView'

  CanvasVisual =          require 'cs!./view/CanvasVisual'

  synthItemTpl = require 'text!./templates/synthItem.html'
  navViewTpl = require 'text!./templates/navItem.html'

  manualTpl = require 'text!./templates/manual.html'

  style = require 'less!./css/style.less'
  fontstyle = require 'text!./css/font-awesome.min.css'

  $("head").append("<style>"+fontstyle+"</style>")

  window.isEmpty = (obj) ->
    return true  unless obj?
    return false  if obj.length > 0
    return true  if obj.length is 0
    for key of obj
      return false  if Object::hasOwnProperty.call(obj, key)
    true

  app = {}
  app.collections = {}
  app.drumkitParams = drumkitParams
  app.synthParams = synthParams
  _.each synthParams, (val, key) -> require ["cs!./synthPlugins/"+key]
  app.fxParams = fxParams
  app.navSelect = ""

  cv = new CanvasVisual("canvasvisual")

  app.cv = cv

  app.changeMainView = (navName) ->
    if app.navSelect == navName then return
    app.navSelect = navName
    if navName=="hideList"
      $("#listView").addClass("hide")
      $("#detailView").addClass("fullsize")
      return
    else
      if $("#listView").hasClass("hide")
        $("#listView").removeClass("hide")
        $("#detailView").removeClass("fullsize")

      $("#detailView").fadeOut 50, ->
        $(@).html("").fadeIn(250)

      $("#listView").fadeOut 50, ->
        $(@).html("").fadeIn(250)
        if navName=="synth"
          app.listView = new ListView(
            $("#listView"), "synths", synthItemTpl, Synth
          )
          app.detailView = new SynthDetailView($("#detailView") , "synths")
          app.listView.initialize()
          app.detailView.initEvents()

        else if navName=="manual"
          app.detailView = new DetailView($("#detailView"))
          app.detailView.tpl = manualTpl
          app.detailView.render()

        else if navName=="seq"
          app.listView = new ListView($("#listView"), "seqs", synthItemTpl, Seq)
          app.detailView = new SeqDetailView($("#detailView"), "seqs")
          app.listView.initialize()

        else if navName=="drums"
          app.listView = new ListView($("#listView"), "drumkits", synthItemTpl, Drumkit)
          app.detailView = new DrumkitDetailView($("#detailView"), "drumkits")
          app.listView.initialize()



  window.app = app


  app.collections.navs = [
    new Nav("Hide List", "hideList")
    new Nav("Drums", "drums")
    new Nav("Synths", "synth")
    new Nav("Sequencers", "seq")
    new Nav("Manual", "manual")
  ]

  app.collections.synths = [ new Synth("superSAWtooth") ]
  app.collections.drumkits = [ new Drumkit() ]
  app.collections.seqs = [ new Seq("seq-sequence-1") ]

  app.navView = new NavView($("#navView"), "navs", navViewTpl)
  app.navView.initialize()

  $(".body").show(50)

  app.changeMainView("synth")
