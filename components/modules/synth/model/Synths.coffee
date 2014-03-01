define ["lodash","backbone", "cs!./Synth"],
(_, Backbone, Model) ->

  class Synths extends Backbone.Collection
    model: Model
    url: "/synths/"