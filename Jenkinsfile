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
    AWS_REGION    = "ap-southeast-2"
       VERSION       = getVersion() 
    DEFAULT_DEV_BRANCH   = "develop"
    DEFAULT_STAGE_BRANCH = "none"
    DEFAULT_PROD_BRANCH  = "none"
  }
  stages {
    stage('Build') {
      steps {
        container('builder') {
         
          ansiColor('xterm') {
            sh """#!/bin/sh
              set -xe
              ./gradlew assemble
            """
          }
          stash includes: "build/libs/FPLWeb.jar", name: 'artefact'
        }
      }
    }
