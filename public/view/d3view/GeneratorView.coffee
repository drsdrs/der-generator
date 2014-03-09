define [
  "jquery"
  "underscore"
], ($, _, View) ->
  class GeneratorView
    constructor: (@model, @target)->
      @generators = @model.generators
    initialize: ->
      @container = @svg.init()
      @svg.updateRect(@generators, @container, @model)
      d3.selection::moveToFront = -> @each -> @parentNode.appendChild this


    svg:
      width: 480
      height: 320
      genW: 60
      genH: 80
      genConR: 5
      genHead: 8
      updateRect: (generators, container, model)->
        updateConnections= ->
          d3.select(".linebox").remove()
          connectionG = d3.select("svg")
            .append("g").attr("class", "linebox")
            .selectAll("line")
            .data((d, i)->
              data = []
              _.each model.connections, (conn)->
                p0 = $("#"+conn[0].genId+" ."+conn[0].type+" circle")[0].getCTM()
                p1 = $("#"+conn[1].genId+" ."+conn[1].type+" circle")[0].getCTM()
                data.push({0:p0, 1:p1})
              data
            )
          connectionG
            .enter()
            .append("line")
              .attr("x1", (d)-> d[0].e)
              .attr("x2", (d)-> d[1].e)
              .attr("y1", (d)-> d[0].f)
              .attr("y2", (d)-> d[1].f)
              .style("stroke", "black")
              .style("stroke-width", (d, i)-> c.l d, i; 5)
        updateConnections()
        dragstarted = (d) ->
          d3.event.sourceEvent.stopPropagation()
          d3.select(this).moveToFront().classed("dragging", true)

        dragged = (d) ->
          d.x += d3.event.dx
          d.y += d3.event.dy
          d3.select(this)
            .attr("transform", "translate(" + d.x + "," + d.y + ")")

        dragended = (d) ->
          updateConnections(container, model)
          d3.select(this).classed("dragging", false)

        drag = d3.behavior.drag()
          .origin((d) -> d)
          .on("dragstart", dragstarted)
          .on("drag", dragged)
          .on("dragend", dragended)

        joinSource = {}
        joinTarget = {}

        startGenJoin = (e)->
          target = d3.select(this)
          targetParent = d3.select(this.parentNode)
          targetGen = d3.select(this.parentNode.parentNode)
          classes = targetParent.attr("class").split(" ")
          joinings = d3.selectAll(".joining")
          found = false

          if isEmpty(joinSource)
            joinings.classed("joining", false)
            target.classed("joining", true)
            joinSource =
              genId: targetGen.attr("id")
              type: classes[0]
              direction: classes[1]
              range: classes[2]
          else if joinSource.direction==classes[1]||joinSource.range!=classes[2]
            joinings.classed("joining", false)
            joinSource = {}
            joinTarget = {}
          else
            target.classed("joining", true)
            joinTarget =
              genId: targetGen.attr("id")
              type: classes[0]
              direction: classes[1]
              range: classes[2]

            _.each model.connections, (con)->
              if(con[0].genId==joinSource.genId&&con[0].type==joinSource.type)||(con[1].genId==joinSource.genId && con[1].type==joinSource.type)
                return found = true
                if(con[0].genId==joinTarget.genId&&con[0].type==joinTarget.type)||(con[1].genId==joinTarget.genId && con[1].type==joinTarget.type)
                  return found = true
            model.connections.push([joinTarget, joinSource]) if found==false
            joinSource = joinTarget = {}

          animateFunction = () ->
            target.transition().duration(300)
              .style("stroke-width", "3")
              .transition().duration(300)
              .style("stroke-width", "1")
              .each "end", ->
                if target.attr("class")=="joining" then animateFunction() else return
          animateFunction()

        gen = container.selectAll("rect")
          .data(generators)

        genG = gen
          .enter()
          .append("g")
            .attr("id", (d)-> "ID"+d.id)
            .attr("transform", (d) -> "translate(" + d.x + "," + d.y + ")")
        genG.append("rect")
          .style("stroke", "black")
          .style("fill", "yellow")
          .attr("cx", @genConR)
          .attr("width", @genW)
          .attr "height", (d)->
            iLen = if typeof(d.params.inputs)=="object" then _.keys(d.params.inputs).length else 0
            oLen = if typeof(d.params.outputs)=="object" then _.keys(d.params.outputs).length else 0
            len = if iLen > oLen then iLen else oLen
            h = 25+(16*(len-0.5))

        genG.append("text")
          .text((d)-> d.type)
          .attr("y", @genHead+2)
          .attr("x", 1)
          .attr("textLength", @genW-2)
          .style("font-size", @genHead)
          .style("text-align", "center")

        iVal = []
        oVal = []

        inPuts = genG.selectAll("circle")
          .data (d)->
            val = _.values d.params.inputs||[]
            if val.length>0 then iVal.push(val)
            _.keys d.params.inputs||[]

        outPuts = genG.selectAll("circle")
          .data (d)->
            val = _.values d.params.outputs||[]
            if val.length>0 then oVal.push(val)

            _.keys d.params.outputs||[]

        gimmiFillCol = (range)->
          a = ["#f2b","#b2f","#fb2","#2bf", "#000"]
          if range=="0-20000" then a[0]
          else if range=="0-1" then a[1]
          else if range=="0|1" then a[2]
          else return a[4]

        j = -1
        inPutsG = inPuts.enter()
          .append("g")
          .attr("class", (d, i)->
              if i==0 then j++
              d+" inputs range^"+iVal[j][i]
            )
          .attr("transform", (d, i)-> "translate(5 ,"+(26+(16*i))+")")

        j=-1
        inPutsG
          .append("circle")
            .attr("r", @genConR)
            .attr("cx", 2)
            .style("stroke", "black")
            .style("fill", (d, i)->
                if i==0 then j++
                gimmiFillCol iVal[j][i]
            ).on("mousedown", startGenJoin)


        inPutsG
          .append("text")
            .attr("y", -7)
            .attr("x", -4)
            .attr("textLength", (@genW/2)-4)
            .style("font-size", @genConR)
            .text((d)-> d)

        j=-1
        outPutsG = outPuts
          .enter()
          .append("g")
            .attr("transform", (d, i)-> "translate(25 ," + (26+(16*i)) + ")")
            .attr("class", (d, i)->
              if i==0 then j++
              d + " outputs range^" + oVal[j][i]
            )
        j=-1
        outPutsG
          .append("circle")
            .attr("r", @genConR)
            .attr("cx", -> 28)
            .style("stroke", "black")
            .on("mousedown", startGenJoin)
            .style("fill", (d, i)->
              if i==0 then j++
              gimmiFillCol oVal[j][i]
            )
        outPutsG
          .append("text")
            .attr("y", -7)
            .attr("x", 10)
            .attr("textLength", (@genW/2)-4)
            .style("font-size", @genConR)
            .text((d)-> d)

        gen.call(drag)
        # Exit…
        #rect.exit().remove();

      init: ->
        zoomed = -> container.attr("transform", "translate("+d3.event.translate+")scale("+d3.event.scale+")")
        zoom = d3.behavior.zoom()
          .scaleExtent([ 0.5, 4 ])
          .on("zoom", zoomed)

        svg = d3.select("#detailView")
          .append("svg")
            .attr("width", @width)
            .attr("height", @height*2)
            .style("background", "#edf")
            .append("g")
              .attr("transform", "translate( 0 , 0 )")
              .call(zoom)

        box1 = svg.append("rect")
          .attr("width", @width).attr("height", @height*2)
          .style("fill", "none").style("pointer-events", "all")


        container = svg.append("g")
          .attr("class", "svgContainer")
        container
          .append("g")
            .attr("class", "x axis")
            .selectAll("line")
            .data(d3.range(0, @width, 10.5))
            .enter().append("line")
              .style("stroke", "black").style("stroke-width", 0.2)
              .attr("x1", (d) -> d ).attr("y1", 0)
              .attr("x2", (d) -> d ).attr "y2", @height
        container
          .append("g")
            .attr("class", "y axis")
            .selectAll("line")
            .data(d3.range(0, @height, 11))
            .enter()
            .append("line")
            .style("stroke", "black").style("stroke-width", 0.2)
            .attr("x1", 0).attr("x2", @width)
            .attr("y1", (d) -> d).attr("y2", (d) -> d)
        container