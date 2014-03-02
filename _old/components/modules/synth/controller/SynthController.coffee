define [
  'cs!../../../utilities/Vent'
  'jquery'
  'lodash'
  'backbone'
  'marionette'
  'cs!../view/SynthListView'
  'cs!../view/SynthDetailView'
  'cs!../model/Synth'
  'cs!../view/ListView'
],
( Vent, $, _, Backbone, Marionette, SynthListView, SynthDetailView, Synth, ListView ) ->

  class SynthController extends Backbone.Marionette.Controller

    add: ->
      view = new SynthView model: new Synth
      Vent.trigger 'app:updateRegion', 'contentRegion', view
      view.toggleEdit()

    list: ->
      Vent.trigger 'app:updateRegion', 'listTopRegion', new ListView
      Vent.trigger 'app:updateRegion', 'listRegion', new SynthListView collection: App.Synths