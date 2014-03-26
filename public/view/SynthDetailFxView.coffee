define [
  'jquery'
  'underscore'
  'cs!./DetailView'
  'text!../templates/synthParams.html'

], ($, _, DetailView, synthParamTpl) ->
  class SynthDetailFxView extends DetailView

    init:->
      c.l "INIT FXParamView", @
      @renderAllItems()
      @initSynthFxEvents()
      @setFxParams()

    renderAllItems: ()->
      that = @
      @el = ""
      fxs = @model.fxs
      _.each fxs, (fx, i)->
        params = app.fxParams[fx.name]
        params.id = fx.id
        params.name = fx.name
        that.el += that.renderItem params, synthParamTpl
      @target.html(@el)

    setFxParams: ()->
      that = @
      _.each @model.fxs, (fx, i)->
        fxParams = app.fxParams[fx.name]
        modelFxParams = fx.params
        if !modelFxParams?
          c.l "INIT Synth Params" ,fx
          modelFxParams = {}
          _.each fxParams, (col)->
            _.each col, (data)->
              modelFxParams[data[0].param] = data[0].value
          that.model.fxs[i].params = modelFxParams

    initSynthFxEvents: ()->
      chSlider = (e)->
        parent = $(e.target.parentNode)
        param = parent.find(".param").val()
        val = parseFloat(e.target.value)
        parent.find(".numVal").val(val)
        id = parseInt(e.target.parentNode.parentNode.className.split(" ")[1])
        fx = _.find @model.fxs, (d)-> d.id==id
        fx.fx[param] = val
        fx.params[param] = val
      chNumVal = (e)->
        parent = $(e.target.parentNode)
        param = parent.find(".param").val()
        val = parseFloat(e.target.value)
        parent.find(".fader").val(val)
        id = parseInt(e.target.parentNode.parentNode.className.split(" ")[1])
        fx = _.find @model.fxs, (d)-> d.id==id
        fx.fx[param] = val
        fx.params[param] = val
      # chParamButton = (e)->
        # parent = $(e.target.parentNode)
        # param = parent.find(".param").val()
        # val = e.target.value
        # parent.find(".waveInfo").val(val)
        # id = parseInt(e.target.parentNode.parentNode.className.split(" ")[1])
        # fx = _.find @model.fxs, (d)-> d.id==id
        # fx.fx[param] = val
        # fx.params[param] = val

      @target.find(".fader").change chSlider.bind(@)
      @target.find(".numVal").change chNumVal.bind(@)
      #@target.find("input[type='button']").click chParamButton.bind(@)

