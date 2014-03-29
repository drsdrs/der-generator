define [
  'jquery'
  'underscore'
  'text!../templates/drumkitDetail.html'
  'text!../templates/synthParams.html'

  'cs!./DetailView'
  "cs!./SynthDetailFxView"

], ($, _, tpl, synthParamTpl, DetailView, SynthDetailFxView) ->
  class DrumkitDetailView extends DetailView
    tpl: tpl


    initOtherEvents: ->
      setSynth = (e)->
        @model.synth = e.target.value
        html = @renderSynthParams(e.target.value)
        $(".synthParamWrap").html(html)
        @model.drumkitParams = null
        @showDetail()
        @initOtherEvents()
      @target.find(".changeSynth").change setSynth.bind(@)

    showDetail: (model)->
      @model = model = model || @model
      c.l "Show Details", model
      @el = @renderItem(model)
      @render()
      paramsEl = ""
      len = 0
      while len<@model.drums.length
        if len==0 then paramsEl += '<hr>'
        paramsEl += '<div class='+@model.drums[len].id+'><h3 class="drumName">'+@model.drums[len].name+'</h3>'
        paramsEl += @renderSynthParams(@model.drums[len])
        paramsEl += '</div><hr>'
        len++
      $(".drumDetailList").html(paramsEl)
      #@initSynthParamEvents()
      #@initFxView()
      @initRealSynth()
      $("body").unbind("keyup").keyup @playSample.bind(@)

    playSample: (e)->
      if e.target.tagName=="INPUT" then return true
      drums = @model.drums
      k = e.keyCode
      c.l drums
      if k==49||k==81||k==65||k==90
        drums[0].gen.noteOn(160, 0.8)
        $('.'+drums[0].id+" h3").animate({width:"25%"}, 100, "swing", -> $(this).animate({width:"100%"}, 100) )
      else if k==50||k==87||k==83||k==88
        drums[1].gen.noteOn(160, 0.8)
        $('.'+drums[1].id+" h3").animate({width:"25%"}, 100, "swing", -> $(this).animate({width:"100%"}, 100) )
      else if k==51||k==69||k==68||k==67
        drums[2].gen.noteOn(260, 0.8)
        $('.'+drums[2].id+" h3").animate({width:"25%"}, 100, "swing", -> $(this).animate({width:"100%"}, 100) )
      else if k==52||k==82||k==70||k==86
        drums[3].gen.noteOn(360, 0.8)
        $('.'+drums[3].id+" h3").animate({width:"25%"}, 100, "swing", -> $(this).animate({width:"100%"}, 100) )

    renderSynthParams: (synth)->
      that = @
      drumkitParams = app.drumkitParams.basicKit
      modelDrumkitParams = @model.drums[0].drumkitParams
      if !modelDrumkitParams?
        c.l "INIT Synth Params"
        modelDrumkitParams = {}
        _.each drumkitParams, (col)->
          _.each col, (data)->
            modelDrumkitParams[data[0].param] = data[0].value
        _.each @model.drums, (d, i)->
          that.model.drums[i].drumkitParams = modelDrumkitParams
      @renderItem(drumkitParams, synthParamTpl) # renderSynthParamView

    initSynthParamEvents: ()->
      chSlider = (e)->
        c.l "change val"
        parent = $(e.target.parentNode)
        param = parent.find(".param").val()
        val = parseFloat(e.target.value)
        parent.find(".numVal").val(val)
        @model.osc[param](val)
        @model.drumkitParams[param]=val
      chNumVal = (e)->
        c.l "change val"
        parent = $(e.target.parentNode)
        param = parent.find(".param").val()
        val = parseFloat(e.target.value)
        parent.find(".fader").val(val)
        @model.osc[param](val)
        @model.drumkitParams[param]=val
      chParamButton = (e)->
        parent = $(e.target.parentNode)
        param = parent.find(".param").val()
        val = e.target.value
        parent.find(".waveInfo").val(val)
        @model.osc[param](val)
        @model.drumkitParams[param]=val

      @target.find(".fader").change chSlider.bind(@)
      @target.find(".numVal").change chNumVal.bind(@)
      @target.find(".sCell input[type='button']").click chParamButton.bind(@)

    initRealSynth: ()->
      if app.synthDev? then app.synthDev.kill()
      drums = @model.drums
      cv = app.cv
      #fxs = @model.fxs
      audioCallback= (buffer, channelCount) ->
        i = drums.length
        while i--
          drums[i].gen.append buffer, channelCount
        cv.clear()
        cv.draw buffer, channelCount, "rgba(255,128,255, 0.9)"


      dev = audioLib.AudioDevice(audioCallback, 2, 1024<<2)
      dev.kill = ->
        dev.readFn = null
        dev.off()
        dev = null
        cv.clear()

      #osc = audioLib[@model.synth](dev.sampleRate, 440, 44, 0.005)
      # len = @model.fxs.length; i=0
      # while i<len
        # @model.fxs[i].fx = audioLib[@model.fxs[i].name](dev.sampleRate)
        # i++

      app.synthDev = dev
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
