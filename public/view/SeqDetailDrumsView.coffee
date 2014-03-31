define [
  'jquery'
  'underscore'
  'cs!./View'
  'cs!../synthPlugins/loop-sequencer-tweaked.coffee'
  #'cs!../synthPlugins/loop-sequencer.coffee'

], ($, _, View, loopsequencer) ->
  class SeqDetailDrumsView extends View

    initialize: ->
      c.l "init"
      @render @renderItem(@model)
      @initRealSynth()

    initEvents: ->
      @target.find(".beatTrigger").click @setBasicBeat.bind(@)

    setBasicBeat: (e)->
      bbData = @model.drumGenerator.basicBeat.data
      drums = @model.selDrumkit.drums
      e.target.innerHTML = val = (parseInt(e.target.innerHTML)+1)%4
      posInfo = e.target.id.split("p")
      pos = {
        x: parseInt(posInfo[1])
        y: parseInt(posInfo[2])
      }

      event = bbData[pos.y][pos.x]
      if event != 0 then app.seq.removeEvent event

      if val==0
        e.target.className = "beatTrigger velOff"

      else if val==1 then e.target.className = "beatTrigger velLow"
      else if val==2 then e.target.className = "beatTrigger velMid"
      else if val==3 then e.target.className = "beatTrigger velHigh"

      event = app.seq.addEvent pos.x/16, drums[pos.y].gen, "noteOn", 440, val/4
      bbData[pos.y][pos.x] = event



    initRealSynth: ()->
      if app.dev? then app.dev.kill()
      drums = @model.selDrumkit.drums
      cv = app.cv
      #fxs = @model.fxs

      dev = new audioLib.Sink()
      seq = new audioLib.LoopSequencer(dev.sampleRate)

      seq.length = 1
      c.l seq

      seq.kill = ->
        #seq.getMix = null
        #seq.ongenerate = null
        seq = null
        sequence = []

        cv.clear()

      seq.getMix = (ch) ->
          i = drums.length-1
          res = drums[drums.length-1].gen.getMix()
          while i--
            res += drums[i].gen.getMix()
          res

      seq.ongenerate = ->
        i = drums.length
        while i--
          drums[i].gen.generate()

      dev.on "audioprocess", (buffer, channelCount) ->
        cv.clear()
        seq.append buffer, channelCount
        cv.draw buffer, channelCount, "rgba(128,255,128, 0.9)"

      ev = seq.addEvent 1/16, drums[0].gen, "noteOn", 440, 0.5
      seq.removeEvent ev

      app.dev = seq
      app.seq = seq
      #@model.osc = osc
      #@setAllSynthParams(osc)
      #@setAllFxParams()

    setAllSynthParams: (osc)->
      osc = osc || @model.osc
      _.each @model.drumkitParams, (val, key)->
        osc[key](val)
        if typeof(val)!="string" then $("."+key+" .fader, ."+key+" .numVal").val(val)
        else $("."+key+" .waveInfo").val(val)

    setAllFxParams: ()->
      _.each @model.fxs, (fx)->
        _.each fx.params, (val, key)->
          if typeof(val)!="string"
            $("."+fx.id+" ."+key+" .fader, ."+fx.id+" ."+key+" .numVal").val(val)
            $("."+fx.id+" ."+key+" .fader, ."+fx.id+" ."+key+" .numVal").trigger("change")
          else $("."+key.id+" .waveInfo").val(val)
