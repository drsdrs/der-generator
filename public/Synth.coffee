define [
  'jquery'
  'underscore'
  'backbone'
  ],

($, _, Backbone) ->
  class Synth
    constructor: (@name, @pos) ->
      @id = _.now
