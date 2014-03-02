require.config({
	deps: ["cs!/App"],
	baseUrl: '/lib',
	paths: {
		jquery: "jquery/dist/jquery",
		underscore: "underscore-amd/underscore",
		backbone: "backbone-amd/backbone",
		marionette: "marionette/lib/core/amd/backbone.marionette",
		wreqr: "backbone.wreqr/lib/amd/backbone.wreqr",
		babysitter: "backbone.babysitter/lib/amd/backbone.babysitter",
		localstorage: "backbone.localStorage//backbone.localStorage",
		text: 'requirejs-text/text',
		tpl: 'requirejs-tpl/tpl',
		cs: 'require-cs/cs',
		fileupload: 'lib/blueimp-file-upload/js/jquery.fileupload'
	},
    map: {
        "*": {
            "backbone.wreqr": "wreqr",
            "backbone.babysitter": "babysitter",
            "backbone.localStorage": "localstorage"
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
		'jquery.fileupload':['jquery'],
	}
});
