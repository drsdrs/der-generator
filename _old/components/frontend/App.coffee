window.c=console;c.l=c.log
define (require)->

  $ = require 'jquery'
  _ = require 'lodash'
  Backbone = require 'backbone'
  Marionette = require 'marionette'
  WelcomeView = require 'cs!./view/WelcomeView'
  NavItems = require 'cs!./model/NavItems'
  NavItem = require 'cs!./model/NavItem'
  NavigationView = require 'cs!./view/NavigationView'
  AppRouter = require 'cs!./router/AppRouter'
  Less = require 'less!./style/main.less'
  Vent = require "cs!./utilities/Vent"

  isMobile = ()->
    userAgent = navigator.userAgent or navigator.vendor or window.opera
    return ((/iPhone|iPod|iPad|Android|BlackBerry|Opera Mini|IEMobile/).test(userAgent))

  App = new Backbone.Marionette.Application

  #App.config = JSON.parse Config
  App.mobile = isMobile()
  App.Modules = {}

  App.addRegions
    navigationRegion:"#navigation"
    contentRegion:"#content"
    infoRegion:"#info"
    overlayRegion: "#overlay"
    listTopRegion: "#list-top"
    listRegion:"#list"

  App.navItems = new NavItems

  App.Router = new AppRouter

  # App.addInitializer = ()->
  App.navigationRegion.show new NavigationView collection: App.navItems
  App.contentRegion.show new WelcomeView


  Vent.on 'app:updateRegion', (region, view)->
    App[region].show view

  App.start
    onStart:->
      synthModule = require "cs!./modules/synth/SynthModule"
      #magazinesModule = require "cs!./modules/magazine/MagazineModule"
      #settingsModule = require "cs!./modules/settings/SettingsModule"
      # for moduleKey, moduleName of App.config.modules
        # NOT Working :(
        # str "cs!./modules/#{moduleKey}/#{moduleName}"
        # require str
        #require "cs!./modules/magazine/MagazineModule"


  App.uploadHandler = (selector, model) ->
    xhr = $(selector).FileUpload
      dataType: 'json'
      url: 'http://localhost:8888'

      done: (e, data) ->
        $.each data.result.files, (index, file) ->
          $('#files').append '<img src="static/synths/' + file.name + '" />'

      progressall: (e, data) ->
        progress = parseInt data.loaded / data.total * 100, 10
        $(selector + " output").append "progressALL = "+progress + '%'

  window.App = App
  Backbone.history.start()
  Vent.trigger 'app:ready'