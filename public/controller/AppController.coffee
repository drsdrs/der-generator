define [
    'jquery'
    'underscore'
    'backbone'
    'marionette'
    'cs!../view/SynthView'
],
($, _, Backbone, Marionette, SynthView) ->

  class AppController extends Backbone.Marionette.Controller

    settings: ->
      c.l "sett up controller"

    welcome: ->
      console.log new SynthView
