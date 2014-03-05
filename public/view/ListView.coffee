define [
  'jquery'
  'underscore'
  'cs!./View'
], ($, _, View) ->
    class ListView extends View
      initEvents: ->
        that= @
        @target.find(".delBtn").click (e)->
          if confirm "Really delete ?"
            that.delItem(e.target.parentElement.id)

        @target.find(".copyBtn").click (e)->
          id = e.target.parentElement.id
          that.copyItem(id, that.findItem(id))

        @target.find(".showDetailBtn").click (e)->
          app.detailView.clearView()
          model = that.findItem(e.target.parentElement.id)
          app.detailView.showDetail(model)
          app.detailView.initEvents()
