var express = require('express'),
	app = express(),
	ejs = require('ejs'),
	BinaryServer = require('binaryjs').BinaryServer,
	audioLib = require('audiolib'),
	server = app.listen(3333),
	io = require('socket.io').listen(server, { log: false }),
	dev, osc, rec, sock;
	;

app.configure(function() {
	app.use(express.static('public'));
	app.use('/lib', express.static(__dirname + '/bower_components'));
	app.use('/lib/audiolib', express.static(__dirname + '/node_modules'));
});


app.get('/', function(req, res){
  app.use('/', express.static(__dirname + '/public/'));
  res.sendfile('./public/index.html');
});

// setTimeout(function(){
// 	var server = BinaryServer({port: 9000});
// 	server.on('connection', function(client){
// 		if (!client) { return "bummer";}
// 		osc	= new audioLib.Oscillator(44100, 440);
// 		dev	= new audioLib.AudioDevice.devices.dummy(audioProcess, 2, 4096/2, 44100);
// 		console.log(client);
// 		function audioProcess(buffer){
// 			osc.append(buffer);
// 			var ab = new ArrayBuffer(buffer);
// 			arr=[];
// 			i = buffer.length;
// 			while(i--){ arr[i]=buffer[i]; }
// 			client.send(arr);
// 		}
// 	});	
// }), 1200

