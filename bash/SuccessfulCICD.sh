#!/bin/bash
### Set Environment Variables
export public_dns=$(curl -s http://169.254.169.254/latest/meta-data/public-hostname)

### Print Welcome
echo "Welcome To The StartUp Script for the DevOps Best Buy Assignment - Samuel Baruffi"
printf "\n\n\n"
sleep 5

### Making a simple change to README.md so we can do a commit
echo " " >> /home/ubuntu/bbycaSRE/README.md

### Git add/commit the change locally
echo "Commiting Change To Local Repository"
printf "\n\n\n"
sleep 5
cd /home/ubuntu/bbycaSRE/
rm /home/ubuntu/bbycaSRE/bestbuy.ca.js
cat << 'EOL' >> /home/ubuntu/bbycaSRE/bestbuy.ca.js
/**
 * * Module dependencies.
 * */

var express = require('express');
var app = express();
var path = require('path');
var ejs = require('ejs');


app.set('views', __dirname + '/views');
app.engine('html', require('ejs').renderFile);
app.set('view engine', 'ejs');

var routes = require('./routes/routes.js');

app.set('port', process.env.PORT || 8000);

switch (process.env.ENV){
   case 'DEV':
        msg = 'Unleash the power of our people'
        break;
   case 'TEST':
        msg = 'Show respect, humility and integrity'
        break;
   case 'DR':
        msg = 'Learn from challenge and change'
        break;
   case 'PROD':
        msg = 'Have fun while being the best'
        break;
    default:
        msg = 'Environment not defined'
}

app.use(express.static(path.join(__dirname, 'public')));

app.get('/', function(req, res) {

          res.render(__dirname + '/views/index.html', {msg: msg});

}).listen(app.get('port'));
EOL

git add bestbuy.ca.js
git add README.md
git commit -m "Triggering a build on the CI/CD pipeline for the Best Buy DevOps Assignment - Samuel Baruffi"
git pull
printf "\n\n\n"

### Pushing the change to GitHub which will then trigger a job build on Jenkins
echo "Pushing Changes To GitHub (https://github.com/bestbuydevops/bbycaSRE)"
printf "\n\n\n"
sleep 3
git push

### Print To Check Jenkins
printf "\n\n\n\n\n"
echo "Please Navigate to the Jenkins Blue Ocean Pipeline To See The Pipeline Changes Live via:"
echo "http://${public_dns}:8080/blue/organizations/jenkins/bbycaSRE_samuelbaruffi/activity"
printf "\n"
echo "You can also login to Slack to check alerts of the CI/CD pipeline via (username/password in the PDF document):"
echo "https://bestbuydevops.slack.com/messages/CCPMTRHUM/"
