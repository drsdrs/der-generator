define [
  'jquery'
  'underscore'
], ($, _) ->
  class View
    constructor: (@target, @collectionName, @tpl, @model)->
    el: ""
    initialize: ->
      @render(@renderAllItems())

    copyItem: (id) ->
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
      app.detailView.clearView()
      $("#"+id)[0].remove()
      _.find app.collections[@collectionName], (model, i)-> # search and delete model
        app.collections[that.collectionName].splice(i, 1) if model.id == id

    findItem: (id, collection) ->
      _.findWhere(app.collections[ collection||@collectionName ], {"id":parseInt(id)})

    render: (el)->
      @target.html(el||@el)
      @initEvents()
      @el=""

    renderItem: (model, tpl) ->
      _.templateSettings.variable = "model"
      template = _.template tpl||@tpl
      template model||@model

    renderAllItems: ()->
      that = @
      collection = app.collections[@collectionName]
      _.each collection, (model, i)->
        model.pos = i
        that.el += that.renderItem model

