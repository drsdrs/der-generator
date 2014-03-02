window.c=console;c.l=c.log



define (require)->
  $ = require 'jquery'
  _ = require 'underscore'
  localstorage = require 'localstorage'
  Synth = require 'cs!./model/Synth'
  SynthView = require 'cs!./view/SynthView'

  app = {}
  app.synths = [
    new Synth()
    new Synth()
    new Synth()
    ]

  app.synthView = new View($("#synthView"), "synths")

  addSynth = ->
    app.synths.push(newItem)
    app.view.renderItem(newItem)

  editItem = (model)->
    false

  removeItem = (model)->
    false


  #View


  window.app = app
  app.synthView.renderAllItems()
  app.view.render()
