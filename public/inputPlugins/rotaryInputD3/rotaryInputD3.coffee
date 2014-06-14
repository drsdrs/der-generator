#lineInputD3.coffee
define (require) ->
  $ = require 'jquery'
  d3 = require 'd3'
  rotaryInputD3 = (els, cfg, osc)->
    s = 1 # total scale    
    w = 100 # default input field size
    els.each (i, el)->

      param = $(el).attr("param")
      param2 = $(el).attr("paramB") || ""
      
      if !cfg? then cfg = {}
      if !cfg[param]? then cfg[param] = {}
      
      if param2.length>0
        cfgNew = cfg[param]
        oscNew = osc[param]
        param = param2
      else
        cfgNew = cfg
        oscNew = osc

      val = cfg[param].value || parseFloat $(el).attr("value")
  
      circleColor = $(el).attr("circleColor")
      max = parseFloat $(el).attr("max")
      orientation = $(el).attr("orientation")
      w = parseFloat $(el).attr("size") || w
      r = w/7.5   # radius of circle
      b = r/4 # border
      tw = w+r*2
      offsetAngle = -112.5
      maxAngle = 360-45

      cfg[param] = val
      osc[param] = val

      svg = d3.select(el).append("svg").attr("width", tw).attr("height", tw)
      group = svg.append("g")
        .attr("transform", "scale("+s+")")
        .attr("transform", "rotate("+( ((max-val)*w)+r+offsetAngle )+", "+(w/2+r)+", "+(w/2+r)+")")

      turn = d3.behavior.drag().on("drag", ()->
        offs = 0.01
        if d3.event.dy>offs || d3.event.dy>offs then val = -3
        else if d3.event.dy<-offs || d3.event.dy<-offs then val = 3

        rot = parseInt(
          group.attr("transform").split("(")[1].split(",")[0]
        )+val

        if rot>360+offsetAngle-45 then rot = 360+offsetAngle-45
        else if rot<=offsetAngle then rot = offsetAngle
        group.attr("transform", "rotate("+(rot)+", "+(w/2+r)+", "+(w/2+r)+")")
      ).on("dragend", ()->
        pos = parseInt(group.attr("transform").split("(")[1].split(",")[0])
        val = (((pos-offsetAngle)/maxAngle)*max)
        # $(el).attr("startVal", y)
        cfg[param] = val
        osc[param] = val
      )

      line = group.append("line")
        .attr("x1", r*2.5).attr("y1", r*2.5)
        .attr("x2", w/2).attr("y2", w/2)
        .attr("stroke-width", r).attr("stroke", "rgba(0, 0, 0, 0.6)")
        .attr("stroke-linecap", "round")


      circle = group.append("circle")
        .attr("cx", w/2+r).attr("cy", w/2+r).attr("r", w/2)
        .attr("fill", circleColor)
        .attr("stroke-width", r).attr("stroke", "rgba(0, 0, 0, 0.6)")
        .call(turn)
