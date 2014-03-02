define ['jquery', 'underscore', 'backbone', 'tpl!../templates/item.html', 'tpl!../templates/list.html'],
($, _, Backbone, Template, ListTemplate) ->

  class SynthItemView extends Backbone.Marionette.ItemView
    template: Template

  class SynthListView extends Backbone.Marionette.CollectionView
    itemView: SynthItemView
