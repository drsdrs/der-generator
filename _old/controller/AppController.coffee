define [
    'jquery'
    'underscore'
    'backbone'
    'marionette'
    'cs!../view/SynthView'
],
($, _, Backbone, Marionette, SynthView) ->

  class AppController extends Backbone.Marionette.Controller

    welcome: ->
      c.l "say welcome"
