define [
  'jquery'
  'underscore'
], ($, _, View) ->
    class GeneratorView
      constructor: (@generators, @target)->
      initialize: ->
        @container = @svg.init()
        @svg.updateRect(@generators, @container)
        #@addAll()
        #@dragDropDemo()

      svg:
        width: 480
        height: 320

        updateRect: (generators, container)->
          dragstarted = (d) ->
            d3.event.sourceEvent.stopPropagation()
            d3.select(this).classed "dragging", true

          dragged = (d) -> d3.select(this).attr("cx", d.x = d3.event.x).attr "cy", d.y = d3.event.y

          dragended = (d) -> d3.select(this).classed "dragging", false

          drag = d3.behavior.drag()
            .origin((d) -> d)
            .on("dragstart", dragstarted)
            .on("drag", dragged)
            .on("dragend", dragended)
          # Update…
          rect = container.selectAll("rect")
              .data(generators)
          # Enter…
          rect.enter().append("rect")
              .style("stroke", "black")
              .style("fill", "yellow")
              .attr("id", (d)-> d.id)
              .attr("x", (d)-> d.x)
              .attr("y", (d)-> d.y)
              .attr("rx", 5).attr("ry", 5)
              .attr("cx", 5).attr("cy", 5)
              .attr("width", 50)
              .attr("height", 80).call(drag)
          # Exit…
          rect.exit().remove();

        init: ->
          zoomed = ->
            container.attr "transform", "translate(" + d3.event.translate + ")scale(" + d3.event.scale + ")"

          zoom = d3.behavior.zoom()
            .scaleExtent([ 1, 10 ])
            .on("zoom", zoomed)

          svg = d3.select("#detailView")
            .append("svg")
              .attr("width", @width)
              .attr("height", @height*2)
              .append("g")
                .attr("transform", "translate( 0 , 0 )")
                .call(zoom)

          box1 = svg.append("rect")
            .attr("width", @width).attr("height", @height)
            .style("fill", "none").style("pointer-events", "all")
          container = svg.append("g")
          container
            .append("g")
              .attr("class", "x axis")
                .selectAll("line")
                .data(d3.range(0, @width, 10))
                .enter().append("line")
                .attr("x1", (d) -> d ).attr("y1", 0)
                .attr("x2", (d) -> d ).attr "y2", @height
          container
            .append("g")
              .attr("class", "y axis")
              .selectAll("line")
              .data(d3.range(0, @height, 10))
              .enter()
              .append("line")
                .style("stroke", "black").style("stroke-width", 0.4)
                .attr("x1", 0).attr("x2", @width)
                .attr("y1", (d) -> d).attr("y2", (d) -> d)
          container
