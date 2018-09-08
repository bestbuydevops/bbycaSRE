var expect  = require('chai').expect;
var request = require('request');
var port = process.env.PORT
var env = process.env.ENV

it('Main page content', function(done) {
    request('http://localhost:'+ port , function(error, response, body) {
        switch (env){
            case 'DEV':
             expect(body).to.contain('Unleash the power of our people')
             break;
            case 'TEST':
             expect(body).to.contain('Show respect, humility and integrity')
             break; 
            case 'DR':
             expect(body).to.contain('Learn from challenge and change')
             break;
            case 'PROD':
             expect(body).to.contain('Have fun while being the best')
             break; 
        }
        done();
    });
});

