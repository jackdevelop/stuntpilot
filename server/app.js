
/**
 * Module dependencies.
 */

var express = require('express');
var routes = require('./routes');
var user = require('./routes/user');
var test = require('./routes/test');
var http = require('http');
var path = require('path');

var app = express();

// Authenticator
app.use(express.basicAuth(function(user, pass, fn) {
    var result = (user === 'admin' && pass === 'creativeproject');
    fn(null /* error */, result);
}));

// all environments
app.set('port', process.env.PORT || 3000);
//app.set('views', path.join(__dirname, 'views'));
//app.set('view engine', 'ejs');
//app.use(express.favicon());
app.use(express.logger('dev'));
app.use(express.json());
app.use(express.urlencoded());
app.use(express.methodOverride());
app.use(app.router);
//app.use(express.static(path.join(__dirname, 'public')));

// development only
if ('development' == app.get('env')) {
  app.use(express.errorHandler());
}

app.post('/', routes.index);
app.post('/users', user.list);
app.post('/tests', test.json_body);

http.createServer(app).listen(app.get('port'), function(){
  console.log('Express server listening on port ' + app.get('port'));
});
