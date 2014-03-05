window.c=console;c.l=c.log;c.w=c.warn

define (require)->
  $ = require 'jquery'
  _ = require 'underscore'
  d3 = require 'd3'

  Synth = require 'cs!./model/Synth'
  Seq = require 'cs!./model/Seq'
  Nav = require 'cs!./model/Nav'

  synthParams = require 'cs!./model/synthParams'

  ListView = require 'cs!./view/ListView'
  DetailView = require 'cs!./view/DetailView'
  SynthDetailView = require 'cs!./view/SynthDetailView'
  SeqDetailView = require 'cs!./view/SeqDetailView'
  NavView = require 'cs!./view/NavView'
  BoldView = require 'cs!./view/NavView'

  synthViewTpl = require 'text!./templates/synthItem.html'
  navViewTpl = require 'text!./templates/navItem.html'

  manualTpl = require 'text!./templates/manual.html'
  style = require 'less!./style.less'


  app = {}
  app.collections = {}
  app.synthParams = synthParams;
  app.navSelect = ""

  app.changeMainView = (navName) ->
    if app.navSelect == navName then return
    navSelect = navName
    $("#detailView").fadeOut 150, ->
      $(@).html("").fadeIn(150)
    $("#listView").fadeOut 150, ->
      $(@).html("").fadeIn(150)

      if navName=="synth"
        app.listView = new ListView($("#listView") , "synths", synthViewTpl, Synth)
        app.detailView = new SynthDetailView($("#detailView") , "synths")
        app.listView.initialize()
        app.detailView.initEvents()

      else if navName=="manual"
        app.detailView = new DetailView($("#detailView"))
        app.detailView.tpl = manualTpl
        app.detailView.render()

      else if navName=="seq"
        app.listView = new ListView($("#listView"), "seqs", synthViewTpl, Seq)
        app.detailView = new SeqDetailView($("#detailView"), "seqs")
        app.listView.initialize()


  window.app = app


  app.collections.synths = [
    new Synth()
    new Synth()
    new Synth()
  ]

  app.collections.navs = [
    new Nav("Synths", "synth")
    new Nav("Sequencers", "seq")
    new Nav("Manual", "manual")
  ]

  app.collections.seqs = [
    new Seq("seq-sequence-1")
    new Seq("seq-sequence-34")
    new Seq("seq-sequence-5")
  ]

  app.navView = new NavView($("#navView"), "navs", navViewTpl)
  app.navView.initialize()

  $("body").show(50)

  app.changeMainView("synth")
