define ['underscore', 'audiolib'], (_) ->

  class SynthGenerator
    constructor: (@type)->
      @gen= audioLib[@type]
      @params= app.synthParams[@type]
      @id= (parseInt((1024^Math.random()*1024).toString()+Date.now().toString()))
      @x= ~~(Math.random()*255)
      @y= ~~(Math.random()*255)

  class Synth
    constructor: (@name)->
      @name= @name || "Neuer Synth"+ ~~(Math.random()*1024)
      @id= (parseInt((1024^Math.random()*1024).toString()+Date.now().toString()))
      @synthParams = app.synthParams
      @generators = []
      @connections = []

    addGen: (type)->
      synthGen = new SynthGenerator(type||"Oscillator")
      if synthGen.gen==undefined
        c.w "No SynthGenerator type found in Audiolib with the name ", type
        #return
      @generators.push(synthGen)
