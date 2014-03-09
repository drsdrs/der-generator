define [
  'jquery'
  'underscore'
  'cs!./DetailView'
  'cs!./d3view/GeneratorView'
  'text!../templates/detailSynth.html'
], ($, _, DetailView, GeneratorView, tpl) ->
  class SynthDetailView extends DetailView
    tpl: tpl
    initOtherEvents: ->
      @target.find("#addGenerator").keyup (e) ->
        @addGenerator()

    showDetail: (model)->
      @model = model
      @el = @renderItem(model)
      @render()
      generators = model.generators
      if generators.length == 0
        model.addGen("Keyboard")
        model.addGen("Oscillator")
        model.addGen("ADSREnvelope")
        model.addGen("Chorus")
        #model.addGen("Output")
      @renderSvgSynthDetail(model)

    renderSvgSynthDetail: (model) ->
      generatorView = new GeneratorView(model, @target)
      generatorView.initialize()

    addGenerator: ()->
      app.collections.synths.push(@model.addGen("Amp"))

