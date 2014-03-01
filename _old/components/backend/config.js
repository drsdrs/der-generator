require.config({
	deps: [
	//"cs!/admin/App",
	"cs!/admin/App2"],
	baseUrl: '/admin/lib',
	paths: {
		jquery: "jquery/dist/jquery",
		audiolib: "../node/audiolib/lib/audiolib",
		loopsequencer: "../node/audiolib/plugins/loop-sequencer",
		lodash: "lodash-amd/main",
		underscore: "underscore-amd/underscore",
		wreqr: "backbone.wreqr/lib/amd/backbone.wreqr",
		babysitter: "backbone.babysitter/lib/amd/backbone.babysitter",
		backbone: "backbone-amd/backbone",
		marionette: "marionette/lib/core/amd/backbone.marionette",
        localstorage: "backbone-localstorage/backbone-localstorage",
		text: 'requirejs-text/text',
		tpl: 'requirejs-tpl/tpl',
		cs: 'require-cs/cs',
		fileupload: 'lib/blueimp-file-upload/js/jquery.fileupload'
	},
    map: {
        "*": {
            "backbone.wreqr": "wreqr",
            "backbone.babysitter": "babysitter"
        }
    },
	packages: [
      {
        name: 'less',
        location: 'require-less',
        main: 'less'
      },{
	    name: 'cs',
	    location: 'require-cs',
	    main: 'cs'
	  },{
	  	location: 'coffee-script',
	    name: 'coffee-script',
	    main: 'index'
	  }
    ],
	shim: {
		'loopsequencer':['audiolib'],
	}
});
