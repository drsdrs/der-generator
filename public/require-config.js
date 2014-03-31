require.config({
	deps : ["cs!/App"],
	baseUrl : '/lib',
	paths : {
		jquery : "jquery/dist/jquery",
		d3 : "d3-amd/d3",
		audiolib : "./../audiolib/audiolib",
		underscore : "underscore-amd/underscore",
		text : 'requirejs-text/text',
		tpl : 'requirejs-tpl/tpl',
		cs : 'require-cs/cs',
	},
	map : {
		"*" : {
			"backbone.wreqr" : "wreqr",
			"backbone.babysitter" : "babysitter",
			"backbone.localStorage" : "localstorage"
		}
	},
	packages : [{
		name : 'less',
		location : 'require-less',
		main : 'less'
	}, {
		name : 'cs',
		location : 'require-cs',
		main : 'cs'
	}, {
		location : 'coffee-script',
		name : 'coffee-script',
		main : 'index'
	}]

});
