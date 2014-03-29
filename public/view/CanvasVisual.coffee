define [], ->
  class canvasVis
    constructor: (el)->
      @canvas = document.getElementById(el)
      @context = @canvas.getContext("2d")
      @width = @canvas.width = 1023
      @height = @canvas.height = 70
      @canvas.width = @width
      @zoom = 2
      @speed = 2
      @halt = false

      #document.body.appendChild @canvas

      @canvas.addEventListener "mousedown", @haltVis.bind(@)
      @canvas.addEventListener "mouseup", @haltVis.bind(@)
      @canvas.ondblclick = @haltVis.bind(@)

    haltVis: -> @halt = !@halt

    clear: ->
      if @halt==true then return
      @context.beginPath();
      @context.fillRect(0,0, @width, @height);
      @context.stroke();

    drawBuff: (buffer, channelCount, color) ->


    draw: (buffer, channelCount, color)->
      #@buffer = buffer
      if @halt==true then return
      @context.beginPath()
      @context.strokeStyle = color
      @context.lineWidth = 2
      i = 0
      len = buffer.length
      p = (@width / len)*@speed
      while i < len
        @context.lineTo (p*i), (((buffer[i]*@zoom)/2+0.5)*@height)
        i+=channelCount

      @context.stroke()
