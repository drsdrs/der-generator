define ['jquery', 'lodash', 'backbone', 'tpl!../templates/listItem.html', 'tpl!../templates/list.html', 'tpl!../templates/filter.html'],
($, _, Backbone, Template, ListTemplate, FilterTemplate) ->

  class SynthListItemView extends Backbone.Marionette.ItemView
    template: Template
#
#
  # class FilterView extends Backbone.View
    # tagName: 'fieldset'
    # initialize: ->
      # @template = FilterTemplate
    # render: ->
      # @$el.html @template()
      # @el
    # events:
      # "click #add": "addAction"
    # addAction: ->
      # if $("#showSynths").parent().hasClass("active") then App.navigate "synth/new", true else App.navigate "magazine/new", true
      # return false



  class SynthListView extends Backbone.Marionette.CollectionView
    itemView: SynthListItemView
