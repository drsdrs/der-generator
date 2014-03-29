define [
  'jquery'
  'underscore'
  'cs!./DetailView'
  'text!../templates/seqDetail.html'
  'cs!./SeqDetailDrumsView'
  'text!../templates/seqParamDrums.html'

], ($, _, DetailView, tpl, DrumsView, drumsTpl) ->
  class SeqDetailView extends DetailView
    tpl: tpl
    initOtherEvents: ->
      that = @
      @target.find(".selSynth").change (e)->
        if e.target.selectedIndex==0 then return
        seqModel = that.findItem(e.target.parentElement.id)
        synthModel = that.findItem(
          e.target[e.target.selectedIndex].className, "synths"
        )
        seqModel.selDrum = synthModel
      @target.find(".selDrumkit").change (e)->
        if e.target.selectedIndex==0 then return
        seqModel = that.findItem(e.target.parentElement.id)
        drumModel = that.findItem(
          e.target[e.target.selectedIndex].className, "drumkits"
        )
        seqModel.selDrumkit = drumModel

    showDetail: (model)->
      model.synths = app.collections.synths
      @el = @renderItem(model)
      @render()

      drumsView = new DrumsView($(".drumSection"), null, drumsTpl, model);
      drumsView.initialize()

      if model.selSynth==false then return
      ## set option select element
      select = @target.find(".selSynth")[0]
      index = 0
      _.each select, (sel, i, ins)->
        return index=i if model.selSynth.id == parseInt(sel.className)
      $("."+model.selSynth.id).attr('selected', index)

