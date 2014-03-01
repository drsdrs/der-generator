window.c=console;c.l=c.log



define (require)->
  $ = require 'jquery'
  _ = require 'underscore'
  Synth = require 'cs!./Synth'

  #Synth = require 'cs!./Synth'

  c.l Synth
  window.app = {}
  app.synth = new Synth "herold"


