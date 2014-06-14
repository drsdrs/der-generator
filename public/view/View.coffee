define [
  'jquery'
  'underscore'
], ($, _) ->

  class View
    constructor: (@target, @collectionName, @tpl)->
      that = @

      @el = ""

      @initialize = ->
        @renderAllItems()
        @render()

      @render = ->
        @target.html(@el)
        @initEvents()
        @el=""

      @renderItem = (model) ->
        _.templateSettings.variable = "model"
        template = _.template(@tpl)
        template(model)

      @renderAllItems = ()->
        collection = app.collections[@collectionName]
        _.each collection, (model, i)->
          model.pos = i
          that.el += that.renderItem model

      @delItem = (id) ->
        $("#"+id)[0].remove()
        _.find app.collections[@collectionName], (model, i)-> # search and delete model
          return app.collections[that.collectionName].splice(i, 1) if model.id = id

    initEvents: ->
      that= @
      @target.find(".delBtn").click((e)->
        if confirm "Really delete synth ?"
          that.delItem(e.target.parentElement.id)
      )
