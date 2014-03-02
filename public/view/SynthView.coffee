define [
  'jquery'
  'underscore'
  'text!../templates/item.html'
], ($, _, itemTemplate) ->

  class View
    constructor: (@target, @collection)->
      that = @

      @el = ""
      @target = @target || $("body")

      @initEvents = ->
        @target.find(".delBtn").click((e)->
          id = e.target.parentElement.id
          @delItem(id)
        )


      @render = ->
        @target.html(@el)
        @initEvents()
        @el=""

      @renderItem = (model) ->
        _.templateSettings.variable = "model"
        template = _.template(itemTemplate)
        template(model)

      @renderAllItems = (collection)->
        _.each collection, (synth, i)->
          synth.pos = i
          that.el += that.renderItem synth

      @delItem = (id) ->
        e.target.parentElement.innerHTML = ""
        _.find app.synths, (synth, i)->
          return app.synths.splice(i, 1) if synth.id = id
