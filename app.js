var express = require('express'),
	app = express(),
	ejs = require('ejs')

app.configure(function() {
	app.use(express.static('public'));
	app.use('/lib', express.static(__dirname + '/public/bower_components'));
	app.use(express.cookieParser());
	app.use(express.bodyParser({
          keepExtensions: true,
          limit: 15000000, // 10M limit
          defer: true
    }));

	//routes.setup(app);
});


app.get('/', function(req, res){
  app.use('/', express.static(__dirname + '/public/'));
  res.sendfile('./public/index.html');
});

app.listen(3333);

