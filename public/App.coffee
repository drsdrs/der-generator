window.c=console;c.l=c.log



define (require)->
  $ = require 'jquery'
  _ = require 'underscore'
  localstorage = require 'localstorage'
  Synth = require 'cs!./model/Synth'
  Nav = require 'cs!./model/Nav'
  View = require 'cs!./view/View'
  synthViewTpl = require 'text!./templates/synthItem.html'
  navViewTpl = require 'text!./templates/navItem.html'
  detailSynthTpl = require 'text!./templates/detailSynth.html'
  manualTpl = require 'text!./templates/manual.html'
  style = require 'less!./style.less'

  navSelect = ""

  app = {}
  app.collections = {}
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
    new Synth("seq-sequence-1")
    new Synth("seq-sequence-34")
    new Synth("seq-sequence-5")
  ]


  class NavView extends View
    initEvents: ->
      c.l "init nav"
      @target.find("span").click (e)->
        navName = e.target.className
        app.changeMainView(navName)

  class ListView extends View

  class DetailView extends View
    initEvents: ->
      null
    showDetail: (model)->
      c.l "init detail"
      @el = @renderItem(model)
      @render()
    render: ->
      @target.html("").html(@el||@tpl)
      @el=""

  app.navView = new NavView($("#navView"), "navs", navViewTpl)



  app.changeMainView = (navName) ->
    if navSelect == navName then return c.l "already on this site"
    navSelect = navName
    $("#detailView").slideUp 250, ->
      $(@).html("").slideDown(250)
    $("#listView").slideUp 250, ->
      $(@).html("").slideDown(250)
      if navName=="synth"
        app.synthView = new ListView($("#listView"), "synths", synthViewTpl, Synth)
        app.detailView = new DetailView($("#detailView"), null , detailSynthTpl)
        app.synthView.initialize()
      else if navName=="manual"
        app.manualView = new DetailView($("#detailView"), null, manualTpl)
        app.manualView.render()
      else if navName=="seq"
        app.seqView = new View($("#listView"), "seqs", synthViewTpl, Synth)
        app.detailView = new DetailView($("#detailView"), null , detailSynthTpl)
        app.seqView.initialize()


  addSynth = ->
    app.synths.push(newItem)
    app.view.renderItem(newItem)

  editItem = (model)->
    false

  removeItem = (model)->
    false



  window.app = app
  app.navView.initialize()
  $("body").show(250)
