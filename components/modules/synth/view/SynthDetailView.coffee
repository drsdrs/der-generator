define ['jquery', 'lodash', 'backbone', 'tpl!../templates/detail.html', 'cs!../model/Synth'], ( $, _, Backbone, Template, Synth) ->

  class SynthDetailView extends Backbone.Marionette.ItemView

    template: Template

    initialize: ->
      # if !@model then @model = new Synth
      @model.bind 'change', @render, @

    ui:
      edit: ".edit"
      preview: ".preview"
      inputTitle: 'input[name=title]'
      inputAuthor: 'input[name=author]'
      inputSynth: 'textarea[name=synth]'
      files: '#files'

    events:
      "click #edit": "toggleEdit"
      "click .save": "saveSynth"
      "click .delete": "deleteSynth"
      'click #publish': "publishSynth"

    toggleEdit: ->
      @ui.edit.toggle()
      @ui.preview.toggle()

    publishSynth: ->
      @model.togglePublish()
      @model.save()

    saveSynth: ->
      files = []
      @ui.files.children().each -> files.push $(this).attr('src')
      @model.set
        title: @ui.inputTitle.val()
        author: @ui.inputAuthor.val()
        images: files
        desc: @ui.inputSynth.val()
      if @model.isNew()
        App.Synths.create @model,
          wait: true
          success: (res) ->
            App.Router.navigate 'synth/'+res.attributes._id, false
      else
        @model.save()
      @toggleEdit()

    deleteSynth: ->
      @model.destroy
        success:->
