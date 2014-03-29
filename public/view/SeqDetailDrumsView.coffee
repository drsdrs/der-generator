define [
  'jquery'
  'underscore'
  'cs!./View'
], ($, _, View) ->
  class SeqDetailDrumsView extends View

    initialize: ->
      c.l "init"
      @render @renderItem(@model)

    initEvents: ->
      @target.find(".beatTrigger").click @setBasicBeat.bind(@)

    setBasicBeat: (e)->
      e.target.innerHTML = val = (parseInt(e.target.innerHTML)+1)%4
      posInfo = e.target.id.split("p")
      pos = {
        x: parseInt(posInfo[1])
        y: parseInt(posInfo[2])
      }

      if val==0 then e.target.className = "beatTrigger velOff"
      else if val==1 then e.target.className = "beatTrigger velLow"
      else if val==2 then e.target.className = "beatTrigger velMid"
      else if val==3 then e.target.className = "beatTrigger velHigh"

      @model.drumGenerator.basicBeat.data[pos.y][pos.x] = val
      c.l @model.drumGenerator.basicBeat.data

