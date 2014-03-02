define ['underscore'], (_) ->

  class Synth
    constructor: ()->
      @name= "Neuer Synth"+ ~~(Math.random()*1024<<6)
      @pos= 0
      @id= -(Date.now()<<6 | Math.random()*64)

