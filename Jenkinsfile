//Author:Samuel Baruffi 
//DevOps Assignment - Best Buy

pipeline {
  //Use any Jenkins agent available
  agent any
  
  //Specifying Tools 
  tools {nodejs "node"}
  
  //CI_CD Pipeline Stages
  stages {
    
    // CI - Unit Test Of The Node App 
    stage('CI - Unit Test') {
      steps {
        // First Slack Notification
        slackSend (color: '#00FF00', message: "@channel *STARTED*: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' (${env.RUN_DISPLAY_URL})")
        
        //Setting Global Environments
        script {
          public_dns = sh(script: 'curl -s http://169.254.169.254/latest/meta-data/public-hostname', returnStdout: true)
        }

        //Setting Stage Environments
        script {
          stage = "CI - Unit Test"
        }

        sh "echo ${stage}"

        // Installing Node Dependencies Packages for Unit Test
        sh 'npm install'
        sh 'npm install pm2 -g'
        
        // Testing DEV 
        withEnv(['ENV=DEV','PORT=8091']) {
                sh "printf 'Testing DEV env \n\n'"
                sh 'pm2 start -f bestbuy.ca.js && npm test'
                sh 'pm2 delete -f bestbuy.ca.js'
        }
        
        // Testing TEST 
        withEnv(['ENV=TEST','PORT=8092']) {
                sh "printf 'Testing TEST env \n\n'"
                sh 'pm2 start -f bestbuy.ca.js && npm test'
                sh 'pm2 delete -f bestbuy.ca.js'
        }
      
        // Testing DR 
        withEnv(['ENV=DR','PORT=8093']) {
                sh "printf 'Testing DR env \n\n'"
                sh 'pm2 start -f bestbuy.ca.js && npm test'
                sh 'pm2 delete -f bestbuy.ca.js'
        }
      
        // Testing PROD 
        withEnv(['ENV=PROD','PORT=8094']) {
                sh "printf 'Testing PROD env \n\n'"
                sh 'pm2 start -f bestbuy.ca.js && npm test'
                sh 'pm2 delete -f bestbuy.ca.js'
        }
      }
    }
    
    // CI -  Docker Build
    stage('CI - Docker Build'){
      steps {
        sh "printf 'CI - Docker Build \n\n'" 
        script {
          def customImage = docker.build("bestbuydevops/bbycasre_samuelbaruffi:latest")
        }
      }
    }
    
    // CI - Push Image To DockerHub
    stage('CI - Push To DockerHub'){
      steps {
        sh "printf 'CI - Push TO DockerHub  \n\n'" 
        withDockerRegistry([credentialsId: 'dockerhub', url: ""]) {
          sh "docker push bestbuydevops/bbycasre_samuelbaruffi:latest"
        }
      }
    }
         
    // CD - Deploy Containers
    stage('CD - Deploy Containers'){
      steps {
        // Deploying Dev Container
        sh "printf 'CD - Deploy DEV Container on Port 8091 \n\n'" 
        sh 'docker stop bestbuydevops-dev || true && docker rm -f bestbuydevops-dev || true'
        sh "docker run -dti -p 8091:8091 -e ENV=DEV -e PORT=8091 --name bestbuydevops-dev bestbuydevops/bbycasre_samuelbaruffi:latest"
        slackSend (color: '#00FF00', message: "@channel *DEPLOYED:* Best Buy App (Samuel Baruffi) (ENV=DEV) (http://${public_dns}:8091)")

        // Deploying Test Container
        sh "printf 'CD - Deploy TEST Container on Port 8092 \n\n'" 
        sh 'docker stop bestbuydevops-test || true && docker rm -f bestbuydevops-test || true'
        sh "docker run -dti -p 8092:8092 -e ENV=TEST -e PORT=8092 --name bestbuydevops-test bestbuydevops/bbycasre_samuelbaruffi:latest"
        slackSend (color: '#00FF00', message: "@channel *DEPLOYED:* Best Buy App (Samuel Baruffi) (ENV=TEST) (http://${public_dns}:8092)")

        // Deploying DR Container
        sh "printf 'CD - Deploy DR Container on Port 8093 \n\n'" 
        sh 'docker stop bestbuydevops-dr || true && docker rm -f bestbuydevops-dr || true'
        sh "docker run -dti -p 8093:8093 -e ENV=DR -e PORT=8093 --name bestbuydevops-dr bestbuydevops/bbycasre_samuelbaruffi:latest"
        slackSend (color: '#00FF00', message: "@channel *DEPLOYED:* Best Buy App (Samuel Baruffi) (ENV=DR) (http://${public_dns}:8093)")

        // Deploying Prod Container
        sh "printf 'CD - Deploy PROD Container on Port 8094 \n\n'" 
        sh 'docker stop bestbuydevops-prod || true && docker rm -f bestbuydevops-prod || true'
        sh "docker run -dti -p 8094:8094 -e ENV=PROD -e PORT=8094 --name bestbuydevops-prod bestbuydevops/bbycasre_samuelbaruffi:latest"
        slackSend (color: '#00FF00', message: "@channel *DEPLOYED:* Best Buy App (Samuel Baruffi) (ENV=PROD) (http://${public_dns}:8094)")
      }      
    }
  }
  
  //Post Functions Alerts/Notifications
  post {
    
    //Notification on Success
    success {
      slackSend (color: '#00FF00', message: "@channel *SUCCESSFUL*: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' (${env.RUN_DISPLAY_URL})")
    }
    
    //Notification on failure
    failure {
      slackSend (color: '#FF0000', message: "@channel *FAILED*: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' (${env.RUN_DISPLAY_URL})")
    }
  }
}

