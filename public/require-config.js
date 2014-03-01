require.config({
	deps: ["cs!/App"],
	baseUrl: '/lib',
	paths: {
		jquery: "jquery/dist/jquery",
		underscore: "underscore-amd/underscore",
		backbone: "backbone-amd/backbone",
		text: 'requirejs-text/text',
		tpl: 'requirejs-tpl/tpl',
		cs: 'require-cs/cs',
		fileupload: 'lib/blueimp-file-upload/js/jquery.fileupload'
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
