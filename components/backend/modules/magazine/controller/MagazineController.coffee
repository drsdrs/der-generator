define [
  'cs!../../../utilities/Ventor'
  'jquery'
  'lodash'
  'backbone'
  'marionette'
  'cs!../view/MagazineListView'
  'cs!../view/MagazineDetailView'
  'cs!../view/PageListView'
  'cs!../model/Magazine'
],
( Vent, $, _, Backbone, Marionette, MagazineListView, MagazineDetailView, Magazine, ListView ) ->

  class MagazineController extends Backbone.Marionette.Controller

    details: (id) ->
      article = App.Magazines.where _id: id
      Vent.trigger 'app:updateRegion', "contentRegion", new MagazineDetailView model: article[0]

    add: ->
      view = new MagazineDetailView model: new Magazine
      Vent.trigger 'app:updateRegion', 'contentRegion', view
      view.toggleEdit()

    list: ->
      Vent.trigger 'app:updateRegion', 'listTopRegion', new ListView
      Vent.trigger 'app:updateRegion', 'listRegion', new MagazineListView collection: App.Magazines