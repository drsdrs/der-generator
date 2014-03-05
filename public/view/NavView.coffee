define [
  'jquery'
  'underscore'
  'cs!./View'
], ($, _, View) ->
  class NavView extends View
    initEvents: ->
      c.l "init nav"
      @target.find("span").click (e)->
        navName = e.target.className
        app.changeMainView(navName)