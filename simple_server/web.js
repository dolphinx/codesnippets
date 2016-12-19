"use static"

const http = require('http');
var i = 0
http.createServer(function (req, res) {
	if (req.url == '/test') {
		++i;
		res.end();
	}
	else {
		console.log(i);
		res.writeHead(404);
		res.end();
	}
}).listen(80);