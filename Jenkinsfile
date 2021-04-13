#!/bin/groovy
pipeline {
  agent {
    kubernetes {
      defaultContainer 'git'
      yamlFile 'jenkins-pod.yaml'
    }
  }
  options {
    timeout(time: 3, unit: 'HOURS')
    preserveStashes(buildCount: 20)
    disableConcurrentBuilds()
  }
  environment {
    AWS_REGION    = "us-east-2"
    DEFAULT_DEV_BRANCH   = "develop"
    DEFAULT_STAGE_BRANCH = "none"
    DEFAULT_PROD_BRANCH  = "none"
  }
  stages {
    
    stage('Clone repository')
                      {
                    	steps{
                                checkout scm
                             }
                      }
    
    stage('Build') {
      steps {
        container('builder') {
         
          ansiColor('xterm') {
            sh "docker build -t some:latest ."
          }
         
        }
      }
    }
  }
}
