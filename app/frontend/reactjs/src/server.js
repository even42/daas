'use strict';

const path = require('path');
const express = require('express');

// Constants
const PORT = 8080;
const HOST = '0.0.0.0';

// App
const app = express();

// ini assets folder
app.use(express.static(path.join(__dirname, 'assets')));

// initialize the server and configure support for ejs templates
app.set('view engine', 'ejs');
app.set('views', path.join(__dirname, 'views'));

// define the folder that will be used for static assets
//app.use(Express.static(path.join(__dirname, 'assets')));

app.get('/', function (req, res) {
    res.render('index', {markup: "Welcome to the DaaS !"});
    //res.send('<html><body style="background:#1a1a1a;font-family: Poppins,Arial,Helvetica,sans-serif;"><div style="color:white;text-align:center;vertical-align:center;padding:2em;front-weight:bolder;font-size:2em">Welcome to the DAAS ! <br/> <br/><br/><img src="https://nodejs.org/static/images/logo.svg" /></div></body></html>')
});

app.listen(PORT);

console.log('Running on http://' + HOST + ':'  + PORT);