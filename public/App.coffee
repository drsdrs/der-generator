window.c=console;c.l=c.log



define (require)->
  $ = require 'jquery'
  _ = require 'underscore'
  backbone = require 'backbone'
  marionette = require 'marionette'
  Synth = require 'cs!./model/Synth'
  Synths = require 'cs!./model/Synths'
  Router = require 'cs!./router/AppRouter'
  SynthView = require 'cs!./view/SynthView'
  Vent = require "cs!./utilities/Vent"


  #Synth = require 'cs!./Synth'

  app = new Backbone.Marionette.Application()

  app.addRegions
    synthRegion:"#synthView"

  app.synths = new Synths
  app.router = new Router

  pade= new Synth name: "haha"

  app.synthRegion.show new SynthView collection: app.synths


  window.app = app
  Backbone.history.start()

  # addItem = ->
    # app.synths.push(newItem)
    # renderItem(newItem)
#
  # editItem = (model)->
    # false
#
  # removeItem = (model)->
    # false
#
#
  # #View
  # synthView = $("#synthView")
#
  # renderItem = (model) ->
    # a = $("#"+model.id)
    # if a.length!=0
      # c.l "destroy view"
#
    # _.templateSettings.variable = "model"
    # template = _.template(itemView)
    # synthView.after template(model)
#
  # renderAllItems = ->
    # _.each app.synths, (synth, i)-> renderItem synth
#
  # renderAllItems()
