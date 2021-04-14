#!/bin/groovy
pipeline {
  agent {
    kubernetes {
      defaultContainer 'jnlp'
      yaml '''
apiVersion: v1
kind: Pod
spec:
  containers
  - name: docker-builder
    image: 'docker:18-git'
    command:
    - cat
    tty: true
         
'''
    }
  }
 
  stages {
       
    stage('Build') {
      steps {
        container('docker-builder') {
         
          
            sh "whoami"
            sh "pwd"
            sh "ls -al"
          
         
        }
      }
    }
  }
}
