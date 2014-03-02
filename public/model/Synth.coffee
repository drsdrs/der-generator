define ['jquery', 'underscore', 'backbone'], ($, _, Backbone) ->

  class Synth extends Backbone.Model
    idAttribute: "_id"
    urlRoot: "synths"
    defaults:
      "title": "Neuer Synth"
      "pos": 0

