define [
  'jquery'
  'underscore'
  'cs!./DetailView'
  'text!../templates/detailSynth.html'
  'text!../templates/synthParams.html'

  "cs!./SynthDetailFxView"

  "cs!../synthPlugins/Synth1"
  "cs!../synthPlugins/BasicSynth"
], ($, _, DetailView, tpl, synthParamTpl, SynthDetailFxView, s1, s2) ->
  class SynthDetailView extends DetailView
    tpl: tpl


    initFxview: ->
      @fxView = new SynthDetailFxView()
      @fxView.model = @model
      @fxView.tpl = @synthParamTpl
      @fxView.init()

    initOtherEvents: ->
      setSynth = (e)->
        @model.synth = e.target.value
        html = @renderSynthParams(e.target.value)
        $(".synthParamWrap").html(html)
        @model.synthParams = null
        @showDetail()
      @target.find("#addEffect").keyup (e) -> @addFx()
      @target.find(".changeSynth").change setSynth.bind(@)

    showDetail: (model)->
      @model = model = model || @model
      @el = @renderItem(model)
      paramsEl = @renderSynthParams(model.synth)
      @render()
      $(".synthParamWrap").html(paramsEl)
      @initSynthParamEvents()
      @initFxview()
      @initRealSynth()

    addFx: (name, params)->
      fx =
        name: name || "Delay"
        params: params || { time: 300, feedback: 0.7}
      @model.fx.push(fx)

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
      @target.find("input[type='button']").click chParamButton.bind(@)

    initRealSynth: ()->
      if app.synthDev? then app.synthDev.kill()
      audioCallback= (buffer, channelCount) ->
        osc.append buffer, channelCount
        len = fxs.length; i=0
        while i<len
          fxs[i].append buffer, channelCount
          i++

      dev = audioLib.AudioDevice(audioCallback, 2, 1024<<2)
      dev.kill = ->
        dev.readFn = null
        dev.off()
        dev = null

      osc = audioLib[@model.synth](dev.sampleRate, 440, 44, 0.005)
      fxs = []
      len = @model.fxs.length; i=0
      while i<len
        fxs[i] = audioLib[@model.fxs[i]](dev.sampleRate)
        i++

      app.synthDev = dev
      @model.osc = osc
      @setAllSynthParams(osc)

    setAllSynthParams: (osc)->
      osc = osc || @model.osc
      _.each @model.synthParams, (val, key)->
        osc[key](val)
        if typeof(val)!="string" then $("."+key+" .fader, ."+key+" .numVal").val(val)
        else $("."+key+" .waveInfo").val(val)
