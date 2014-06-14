require.config({
	deps: ["cs!/App"],
	baseUrl: '/lib',
	paths: {
		jquery: "jquery/dist/jquery",
		underscore: "underscore-amd/underscore",
		audioLib: "audiolib",
		d3: "d3/d3",
		text: 'requirejs-text/text',
		tpl: 'requirejs-tpl/tpl',
		cs: 'require-cs/cs',
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
