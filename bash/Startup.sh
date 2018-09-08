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
