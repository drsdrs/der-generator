define [
  'jquery'
  'underscore'
  'cs!./View'
], ($, _, View) ->
  class DetailView extends View
    constructor: (@target, @collectionName)->
    initEvents: ->
      that = @
      @initOtherEvents()
      @target.find(".changeName").keyup (e)->
        id = parseInt(e.target.parentElement.parentElement.id)
        model = that.findItem(id)
        model.name = e.target.value
        app.listView.initialize()

    clearView: -> $(@target).children().remove()

    showDetail: (model)->
      @el = @renderItem(model)
      @render()

    render: ->
      @target.html("").html(@el||@tpl)
      @el=""