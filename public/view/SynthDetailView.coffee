define [
  'jquery'
  'underscore'
  'text!../templates/synthDetail.html'
  'text!../templates/synthParams.html'

  'cs!./DetailView'
  "cs!./SynthDetailFxView"

], ($, _, tpl, synthParamTpl, DetailView, SynthDetailFxView) ->
  class SynthDetailView extends DetailView
    tpl: tpl

    initFxView: ->
      @fxView = new SynthDetailFxView()
      @fxView.model = @model
      @fxView.target = $(".synthFxWrap")
      @fxView.init()

    initOtherEvents: ->
      setSynth = (e)->
        @model.synth = e.target.value
        html = @renderSynthParams(e.target.value)
        $(".synthParamWrap").html(html)
        @model.synthParams = null
        @showDetail()
        @initOtherEvents()
      @target.find("#addEffect").click @addFx.bind(@)
      @target.find(".changeSynth").change setSynth.bind(@)

    showDetail: (model)->
      @model = model = model || @model
      c.l "Show Details", model
      @el = @renderItem(model)
      @render()
      paramsEl = @renderSynthParams(model.synth)
      $(".synthParamWrap").html(paramsEl)
      @initSynthParamEvents()
      @initFxView()
      @initRealSynth()
      $("body").unbind("keyup").keyup @setOscFreq.bind(@)


    setOscFreq: (e)->
      if e.target.tagName=="INPUT" then return true
      noteFreq = e.keyCode * 3
      @model.osc.setFreq(noteFreq)
      @target.find(".setFreq .fader").val(noteFreq).trigger("change")

    addFx: ->
      name = @target.find(".selectFx").val()
      gen = audioLib[name]
      if !audioLib[name]? then return c.w "no such fx here"
      fx =
        id: (parseInt((1024^Math.random()*1024).toString()+Date.now().toString()))
        name: name
        params: null
        fx: gen()
      c.l fx
      @model.fxs.push(fx)
      @initFxView()
      @setAllFxParams()
      @initRealSynth()

    renderSynthParams: (synth)->
      synthParams = app.synthParams[synth]
      if !synthParams? then return c.w "no such synth in synthParams"
      modelSynthParams = @model.synthParams
      if !modelSynthParams?
        c.l "INIT Synth Params"
        modelSynthParams = {}
        _.each synthParams, (col)->
          _.each col, (data)->
            modelSynthParams[data[0].param] = data[0].value
        @model.synthParams = modelSynthParams
      @renderItem(synthParams, synthParamTpl) # renderSynthParamView

    initSynthParamEvents: ()->
      chSlider = (e)->
        parent = $(e.target.parentNode)
        param = parent.find(".param").val()
        val = parseFloat(e.target.value)
        parent.find(".numVal").val(val)
        @model.osc[param](val)
        @model.synthParams[param]=val
      chNumVal = (e)->
        parent = $(e.target.parentNode)
        param = parent.find(".param").val()
        val = parseFloat(e.target.value)
        parent.find(".fader").val(val)
        @model.osc[param](val)
        @model.synthParams[param]=val
      chParamButton = (e)->
        parent = $(e.target.parentNode)
        param = parent.find(".param").val()
        val = e.target.value
        parent.find(".waveInfo").val(val)
        @model.osc[param](val)
        @model.synthParams[param]=val

      @target.find(".fader").change chSlider.bind(@)
      @target.find(".numVal").change chNumVal.bind(@)
      @target.find(".sCell input[type='button']").click chParamButton.bind(@)

    initRealSynth: ()->
      if app.dev? then app.dev.kill()
      fxs = @model.fxs
      cv = app.cv
      audioCallback= (buffer, channelCount) ->
        osc.append buffer, channelCount
        len = fxs.length; i=0
        while i<len
          fxs[i].fx.append buffer, channelCount
          i++
        cv.clear()
        cv.draw buffer, channelCount, "rgba(255,255,255, 0.9)"


      dev = audioLib.AudioDevice(audioCallback, 2, 1024<<2)
      dev.kill = ->
        dev.readFn = null
        dev.off()
        dev = null
        cv.clear()


      osc = audioLib[@model.synth](dev.sampleRate, 440, 44, 0.005)
      len = @model.fxs.length; i=0
      while i<len
        @model.fxs[i].fx = audioLib[@model.fxs[i].name](dev.sampleRate)
        i++

      app.dev = dev
      @model.osc = osc
      @setAllSynthParams(osc)
      @setAllFxParams()

    setAllSynthParams: (osc)->
      osc = osc || @model.osc
      _.each @model.synthParams, (val, key)->
        osc[key](val)
        if typeof(val)!="string" then $("."+key+" .fader, ."+key+" .numVal").val(val)
        else $("."+key+" .waveInfo").val(val)

    setAllFxParams: ()->
      _.each @model.fxs, (fx)->
        _.each fx.params, (val, key)->
          c.l val, key
          if typeof(val)!="string"
            $("."+fx.id+" ."+key+" .fader, ."+fx.id+" ."+key+" .numVal").val(val)
            $("."+fx.id+" ."+key+" .fader, ."+fx.id+" ."+key+" .numVal").trigger("change")
          else $("."+key.id+" .waveInfo").val(val)
