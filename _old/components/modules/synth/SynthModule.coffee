define [
    'marionette'
    'cs!../../utilities/Vent'
    'cs!./model/Synths'
    'cs!./controller/SynthController'
    "text!./configuration.json"
],
( Marionette, Vent, Synths, Controller, Config ) ->


  Vent.on "app:ready", ()->

    Vent.trigger "app:addModule", JSON.parse Config

    App.Synths = new Synths
    c.l Synths
    App.Synths.fetch
      success:->

    App.Router.processAppRoutes new Controller,
      "synths": "list"
      "synth/:id": "details"
      "newSynth": "add"

    Vent.trigger "synth:ready"
