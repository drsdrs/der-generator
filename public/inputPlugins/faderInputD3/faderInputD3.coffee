#faderInputD3.coffee
define (require) ->
  $ = require 'jquery'
  d3 = require 'd3'
  faderInputD3 = (els, cfg, osc)-> # actionCb is needed to set the synths param
    s = 1 # total scale    
    w = 100 # default input field size
    els.each (i, el)->

      param = $(el).attr("param")
      param2 = $(el).attr("paramB") || ""
      
      #if !cfg? then cfg = {}
      
      if param2.length>0
        if !cfg[param]? then cfg[param] = {}
        cfgNew = cfg[param]
        oscNew = osc[param]
        param = param2
      else
        cfgNew = cfg
        oscNew = osc


      circleColor = $(el).attr("circleColor")
      max = parseFloat $(el).attr("max")
      orientation = $(el).attr("orientation")

      if !cfgNew[param]? then cfgNew[param] = max/2

      val = cfgNew[param] || parseFloat $(el).attr("value")


      w = parseFloat $(el).attr("size") || w
      r = w/7.5 # radius of circle
      b = r/4 # border
      tw = w+r*2

      cfgNew[param] = val
      oscNew[param] = val

      svg = d3.select(el).append("svg")#.attr("width", tw).attr("height", tw)
      group = svg.append("g").attr("transform", "scale("+s+")")

      drag = d3.behavior.drag().on("drag", ()->
        if orientation=="v"
          pos = d3.event.x
          if pos>w+r then pos = w+r else if pos<=r then pos = r
          d3.select(this).attr("cx", pos)
        else if orientation=="h"
          pos = d3.event.y
          if pos>w+r then pos = w+r else if pos<=r then pos = r
          d3.select(this).attr("cy", pos)
      ).on("dragend", ()->
        if orientation=="v" then pos = d3.select(this).attr("cx")
        else if orientation=="h" then pos = d3.select(this).attr("cy")
        val = (((pos-r)/w)*max)
        if orientation=="h" then val = max-val
        $(el).attr("value", val)
        cfgNew[param] = val
        oscNew[param] = val
      )

      val = ((w/max)*val)+r

      group.append("text")
        .attr("x1", r).attr("y1", r)
        .attr("x2", w+r).attr("y2", r)
        .attr("text", "honolulu")
        .attr("fill", "#f00")

      if orientation=="v"
        svg.attr("width", tw*s).attr("height", r*2*s)
        group.append("line")
          .attr("x1", r).attr("y1", r)
          .attr("x2", w+r).attr("y2", r)
          .attr("stroke-width", 6).attr("stroke", "rgba(0, 0, 0, 0.6)")
        circle = group.append("circle")
          .attr("cx", val).attr("cy", r).attr("r", r-b)
          .attr("fill", circleColor).attr("stroke-width", b)
          .call(drag)
      else if orientation=="h"
        svg.attr("width", r*2*s).attr("height", tw*s)
        group.append("line")
          .attr("x1", r).attr("y1", r)
          .attr("x2", r).attr("y2", w+r)
          .attr("stroke-width", r/2).attr("stroke", "rgba(0, 0, 0, 0.6)")
        circle = group.append("circle")
          .attr("cx", r).attr("cy", w-val).attr("r", r-b)
          .attr("fill", circleColor).attr("stroke-width", b)
          .attr("stroke-width", r/4).attr("stroke", "rgba(0, 0, 0, 0.6)")
          .call(drag)