#lineInputD3.coffee
define (require) ->
  $ = require 'jquery'
  d3 = require 'd3'
  lineInputD3 = (els, cfg, osc)-> # actionCb is needed to set the synths param
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


      y1 = cfgNew[param].y1 || 1
      x2 = cfgNew[param].x2 || 0.2
      y2 = cfgNew[param].y2 || 0.2
      y3 = cfgNew[param].y3 || 0

      max = parseFloat $(el).attr("max")
      circleColor = $(el).attr("circleColor")
      w = parseFloat $(el).attr("size") || w
      r = w/7.5   # radius of circle
      b = r/4 # border
      tw = w+r*2

      cfgNew[param].y1 = y1
      cfgNew[param].x2 = x2
      cfgNew[param].y2 = y2
      cfgNew[param].y3 = y3
      oscNew[param].y1 = y1
      oscNew[param].x2 = x2
      oscNew[param].y2 = y2
      oscNew[param].y3 = y3

      svg = d3.select(el).append("svg").attr("width", tw*s).attr("height", tw*s)
      group = svg.append("g").attr("transform", "scale("+s+")")
      rect = group.append("rect")
        .attr("width", w).attr("height", w)
        .attr("rx", 1).attr("ry", 1).attr("x", r).attr("y", r)
        .attr("stroke-width", b)
      #paramText = group.append("text").text(param).attr("x", r).attr("y", r)

      startDrag = d3.behavior.drag().on("drag", ()->
        y = d3.event.y
        if y>w+r then y = w+r else if y<=r then y = r
        d3.select(this).attr("cy", y)
        startLine.attr("y1", y)
      ).on("dragend", ()->
        y = 1-(((startLine.attr("y1")-r)/w)*max)
        $(el).attr("y1", y)
        cfgNew[param].y1 = y
        oscNew[param].y1 = y
      )

      middleDrag = d3.behavior.drag().on("drag", ()->
        y = d3.event.y
        x = d3.event.x
        if y>w+r then y = w+r else if y<=r then y = r
        if x>w+r then x = w+r else if x<=r then x = r
        d3.select(this).attr("cy", y).attr("cx", x)
        startLine.attr("y2", y).attr("x2", x)
        endLine.attr("y1", y).attr("x1", x)
      ).on("dragend", ()->
        y = 1-(((startLine.attr("y2")-r)/w)*max)
        x = (((startLine.attr("x2")-r)/w)*max)
        $(el).attr("x2", x)
        $(el).attr("y2", y)
        cfgNew[param].x2 = x
        cfgNew[param].y2 = y
        oscNew[param].x2 = x
        oscNew[param].y2 = y
      )

      endDrag = d3.behavior.drag().on("drag", ()->
        y = d3.event.y
        if y>w+r then y = w+r else if y<=r then y = r
        d3.select(this).attr("cy", y)
        endLine.attr("y2", y)
      ).on("dragend", ()->
        y = 1-(((endLine.attr("y2")-r)/w)*max)
        $(el).attr("y3", y)
        cfgNew[param].y3 = y
        oscNew[param].y3 = y
      )

      y1 = ((max-y1)*w)+r
      y2 = ((max-y2)*w)+r
      x2 = (x2*w)+r
      y3 = ((max-y3)*w)+r

      startLine = group.append("line")
        .attr("x1", r).attr("y1", y1)
        .attr("x2", x2).attr("y2", y2)
      endLine = group.append("line")
        .attr("x1", x2).attr("y1", y2)
        .attr("x2", w+r).attr("y2", y3)

      startCircle = group.append("circle")
        .attr("cx", r).attr("cy", y1).attr("r", r-b)
        .attr("fill", circleColor).attr("stroke-width", b)
        .call(startDrag)
      middleCircle = group.append("circle")
        .attr("cx", x2).attr("cy", y2).attr("r", r-b)
        .attr("fill", circleColor).attr("stroke-width", b)
        .call(middleDrag)
      endCircle = group.append("circle")
        .attr("cx", w+r).attr("cy", y3).attr("r", r-b)
        .attr("fill", circleColor).attr("stroke-width", b)
        .call(endDrag)
      $('.lineInputD3 circle').trigger("click")