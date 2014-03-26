define  ["underscore",  "audiolib"],  (_)  ->
  class  SynthGenerator
      constructor:  (@type)->
          @gen =  audioLib[@type]
          @params =  app.synthParams[@type]
          @id =  (parseInt((1024^Math.random()*1024).toString()+Date.now().toString()))

  class  Synth
      constructor:  (@name)->
          @name =  @name  ||  "Neuer  Synth"+  ~~(Math.random()*1024)
          @id =  (parseInt((1024^Math.random()*1024).toString()+Date.now().toString()))
          @synth  =  @synth || "Synth1"
          @fxs  =  [ id: 666, name:"Delay", params: null]

      addFx:  (type)->
          fx = audioLib[@type]
          if fx==undefined
              c.w  "No  SynthGenerator  type  found  in  Audiolib  with  the  name  ",  type
              return
          @fxs.push(synthGen)
