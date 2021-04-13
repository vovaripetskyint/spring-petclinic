#!/bin/groovy
pipeline {
  agent {
    kubernetes {
      defaultContainer 'docker-builder'
      yaml """\
       apiVersion: v1
       kind: Pod
       metadata:
       spec:
         serviceAccountName: jenkins
         securityContext:
           runAsUser: 0
           fsGroup: 0
       volumes:
       - name: docker-sock
         hostPath:
           path: /var/run/docker.sock
           type: Socket
       - name: docker-builder
         image: 'docker:18-git'
         command:
         - cat
         tty: true
         volumeMounts:
         - name: docker-sock
           mountPath: /run/docker.sock
         """.stripIndent()
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
        container('docker-builder') {
         
          ansiColor('xterm') {
            sh "docker build -t some:latest ."
          }
         
        }
      }
    }
  }
}
