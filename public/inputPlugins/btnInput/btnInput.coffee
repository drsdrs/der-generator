#faderInputD3.coffee
define (require) ->
  $ = require 'jquery'
  btnInput = (els, cfg, osc)-> # actionCb is needed to set the synths param
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

      size = $(el).attr("size")
      color = $(el).attr("color")
      value = $(el).attr("value")
      values = $(el).attr("values").split(" ")
      orientation = if $(el).hasClass("vertical") then "v" else if $(el).hasClass("horizontal") then "h"


      value = cfg[param] || value
      cfgNew[param] = value
      oscNew[param] = value

      click = (e)->
        e.stopPropagation()
        val = e.target.className
        cfgNew[param] = val
        oscNew[param] = val

      valueCnt = 0
      ul = $("<ul></ul>")
      style = "<style>"
      style += ".btnInput ul li div { background: "+color+"; }"
      if orientation=="h"
        li = $("<li></li>")
        while valueCnt < values.length
          btn = $("<div class="+values[valueCnt]+">"+values[valueCnt]+"</div>").click(click)
          li.append(btn)
          valueCnt++
        ul.prepend(li)
        elSize = size / values.length
        style += ".btnInput.horizontal ul li div{"
        style += "height: 26px;"
        style += "width: "+(elSize-2)+"px;"
        style += "font-size: "+(elSize/6)+"px;"
        style += "margin: 2px 4px;"
        style += "line-height: "+(elSize/14)+";}"

      else if orientation=="v"
        while valueCnt < values.length
          li = $("<li></li>")
          btn = $("<div class="+values[valueCnt]+">"+values[valueCnt]+"</div>").click(click)
          li.append(btn)
          ul.prepend(li)
          valueCnt++
        elSize = size / values.length
        style += ".btnInput.vertical ul li div{"
        style += "height: "+(elSize-2)+"px;"
        style += "width: 100px;"
        style += "font-size: "+(elSize/2)+"px;"
        style += "margin: 2px 4px;"
        style += "line-height: "+(elSize/13)+";}"

      style += "</style>"
      $(el).append(ul)
      $(el).append(style)
