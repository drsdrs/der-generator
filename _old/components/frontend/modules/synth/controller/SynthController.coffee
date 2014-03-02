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

    details: (id) ->
      synth = App.Synths.where _id: id
      Vent.trigger 'app:updateRegion', "contentRegion", new SynthDetailView model: synth[0]

    add: ->
      view = new SynthDetailView model: new Synth
      Vent.trigger 'app:updateRegion', 'contentRegion', view
      view.toggleEdit()

    list: ->
      Vent.trigger 'app:updateRegion', 'listTopRegion', new ListView
      Vent.trigger 'app:updateRegion', 'listRegion', new SynthListView collection: App.Synths