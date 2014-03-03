define [
  'jquery'
  'underscore'
], ($, _) ->
  class View
    constructor: (@target, @collectionName, @tpl, @model)->
    el: ""
    that: @
    initialize: ->
      @render(@renderAllItems())

    copyItem: (id) ->
      id = parseInt(id)
      model = @findItem(id)
      newmodel = new @model
      newmodel.id += Date.now()
      newmodel.name = model.name + "-copy"
      app.collections[@collectionName].push(newmodel)
      @render(@renderAllItems())

    delItem: (id) ->
      that = @
      id = parseInt(id)
      if app.collections[@collectionName].length<=1 then return alert "Can't remove last one"
      $("#"+id)[0].remove()
      _.find app.collections[@collectionName], (model, i)-> # search and delete model
        app.collections[that.collectionName].splice(i, 1) if model.id == id

    findItem: (id) ->
      that = @
      _.findWhere(app.collections[that.collectionName], {"id":id})

    render: ->
      @target.html(@el)
      @initEvents()
      @el=""

    renderItem: (model) ->
      _.templateSettings.variable = "model"
      template = _.template(@tpl)
      template(model)

    renderAllItems: ()->
      that = @
      collection = app.collections[@collectionName]
      _.each collection, (model, i)->
        model.pos = i
        that.el += that.renderItem model

    initEvents: ->
      that= @
      @target.find(".delBtn").click (e)->
        if confirm "Really delete ?"
          that.delItem(e.target.parentElement.id)

      @target.find(".copyBtn").click (e)->
        id = e.target.parentElement.id
        c.l "copyBtn"
        that.copyItem(id, that.findItem(id))

      @target.find(".showDetailBtn").click (e)->
        id = parseInt(e.target.parentElement.id)
        model = that.findItem(id)
        app.detailView.showDetail(model)

