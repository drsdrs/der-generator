define [
    'marionette'
    'cs!../../Vent'
    'cs!./model/Magazines'
    'cs!./controller/MagazineController'
    "text!./configuration.json"
],
( Marionette, Vent, Magazines, Controller, Config ) ->


  Vent.on "app:ready", ()->

    Vent.trigger "app:addModule", JSON.parse Config

    App.Magazines = new Magazines
    App.Magazines.fetch
      success:->

    App.Router.processAppRoutes new Controller,
      "magazines": "list"
      "magazine/:id": "details"
      "newMagazine": "add"
