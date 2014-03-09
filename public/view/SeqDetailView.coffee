define [
  'jquery'
  'underscore'
  'cs!./DetailView'
  'text!../templates/detailSeq.html'
], ($, _, DetailView, tpl) ->
  class SeqDetailView extends DetailView
    tpl: tpl
    initOtherEvents: ->
      that = @
      @target.find("select").change (e)->
        if e.target.selectedIndex==0 then return
        seqModel = that.findItem(e.target.parentElement.id)
        synthModel = that.findItem(
          e.target[e.target.selectedIndex].className, "synths"
        )
        seqModel.selSynth = synthModel

    showDetail: (model)->
      model.synths = app.collections.synths
      @el = @renderItem(model)
      @render()
      if model.selSynth==false then return
      ## set option select element
      select = @target.find("select")[0]
      index = 0
      _.each select, (sel, i, ins)->
        return index=i if model.selSynth.id == parseInt(sel.className)
      $("."+model.selSynth.id).attr('selected', index)
