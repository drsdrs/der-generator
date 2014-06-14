#faderInputD3.coffee
define (require) ->
  $ = require 'jquery'

  genArr = (x,y)->
    arr= []; while y-- then arr[y]=[]; xx = x; while xx-- then arr[y][xx]=0; return arr


  seqInput = (els, cfg, seq, osc)-> # actionCb is needed to set the synths param


    els.each (i, el)->

      param = $(el).attr("param")
      
      if !cfg? then cfg = {}
      if !cfg[param]? then cfg[param] = {}
      
      cfgNew = cfg

      stepCnt = steps = parseInt $(el).attr("steps")
      rowCnt = rows = parseInt $(el).attr("rows")

      seq.length = rows

      container = $("<ul></ul>")

      stepVals = cfg[param].stepVals || genArr(stepCnt, rowCnt)
      cfg[param] = stepVals



      clickStep = (e)->
        e.stopPropagation()
        if $(e.target).hasClass("light")
          lightDiv = e.target
          e.target = e.target.parentNode
        else 
          lightDiv = e.target.children[0]

        rowTarget = parseInt $(e.target).attr("row")
        colTarget = parseInt $(e.target).attr("col")
        valTarget = parseInt $(e.target).attr("value")

        valTarget = (valTarget+1)%4
        className = "light"

        seq.removeEvent stepVals[rowTarget][colTarget]
        stepVals[rowTarget][colTarget]==0
        if valTarget==0 
          #if stepVals[rowTarget][colTarget]!=0 
        else if valTarget==1
          className+=" green"
          stepVals[rowTarget][colTarget] =
            seq.addEvent (rowTarget+(colTarget/(steps/rows))), osc, "trigger", 0.4
        else if valTarget==2
          className+=" yellow"
          stepVals[rowTarget][colTarget] =
            seq.addEvent (rowTarget+(colTarget/(steps/rows))), osc, "trigger", 0.7
        else if valTarget==3
          className+=" red"
          stepVals[rowTarget][colTarget] =
            seq.addEvent (rowTarget+(colTarget/(steps/rows))), osc, "trigger", 0.9

        lightDiv.className = className
        $(e.target).attr("value", valTarget)

        stepVals

      while rowCnt--
        colCnt = steps/rows
        row = $("<li></li>")
        if !stepVals[rowCnt]? then stepVals[rowCnt]=[]
        while colCnt--
          stepCnt--
          if !stepVals[rowCnt][colCnt]? then stepVals[rowCnt][colCnt] = 0
          entity = 
            $("<div row="+rowCnt+" col="+colCnt+" value="+stepVals[rowCnt][colCnt]+"><div class='light'></div></div>")
            .click clickStep


          row.prepend(entity)
        container.prepend(row)


      $(el).append(container)


    #ev = seq.addEvent 2/3, osc.Snare, "trigger", 
    #seq.removeEvent ev