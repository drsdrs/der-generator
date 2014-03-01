define (require)->

  $ = require 'jquery'
  _ = require 'lodash'
  Backbone = require 'backbone'
  Marionette = require 'marionette'

  require 'audiolib'
  require 'loopsequencer'
  Audiolib = audioLib
  dev = Audiolib.Sink()
  window.c=console;c.l=c.log

  dev= new Audiolib.Sink()



  class Osc extends Backbone.Model
    defaults:
      "name": "Default Oscillator"
      "frequency": 440
      "pulseWidth": 0.5
      "waveShape": 0
      "osc"

  class Oscs extends Backbone.Collection
    model: Osc

  class NavigationItemView extends Backbone.Marionette.ItemView
    template: Template
    tagName: 'li'

  class NavigationView extends Backbone.Marionette.CollectionView
    el: "#navigation"
    itemView: NavigationItemView

    events:
      "click li": "clicked"

    clicked: (e)->
      @children.each (view)->
        view.$el.removeClass "active"
      $(e.target).parent().addClass "active"

  osc = new Osc({frequency: 760})




  c.l osc



  app = {
    sampleRate: dev.sampleRate
    seq: new audioLib.LoopSequencer(dev.sampleRate, 90, 1)
    oscs:[
        new Audiolib.Oscillator(dev.sampleRate)
        new Audiolib.Oscillator(dev.sampleRate)
        new Audiolib.Oscillator(dev.sampleRate)
        new Audiolib.Oscillator(dev.sampleRate)
        new Audiolib.Oscillator(dev.sampleRate)
        new Audiolib.Oscillator(dev.sampleRate)
      ]
    genFunct: ->
      a=null
      b=null
      _.each @osc, (osc, i)->
        osc.frequency = (i*100)+200
        b = osc.getMix
        if a!=null then a = multi(a, b, 1, 1) else a = b
      c.l a,b
  }

  multi = (f1, f2, param1, param2)->
    f1(param1)*f2(param2)

  app.init = ->
    that = this
    app.seq.getMix = (ch) ->
      app.osc[0].getMix(ch) * 0.3

    app.seq.ongenerate = ->
      app.osc[0].generate()

    dev.on "audioprocess", (buffer, channelCount) ->
      app.seq.append buffer, channelCount


  window.app = app
  app.genFunct()
  #app.init()

