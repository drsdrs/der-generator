define ['jquery', 'lodash', 'backbone'], ($, _, Backbone) ->
  class Synth extends Backbone.Model
    idAttribute: "_id"
    urlRoot: "synths"
    defaults:
      "title": "Neuer Artikel"
      "desc": "Hello World!"
      "images": ""
      "author": "dnilabs"
      "privatecode": true

    togglePublish: ->
      @.set "privatecode", not @.get "privatecode";

