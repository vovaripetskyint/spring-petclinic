#!/bin/groovy
pipeline {
  agent {
    kubernetes {
      defaultContainer 'git'
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
       containers:
       - name: git
         image: alpine/git:latest
         command:
         - cat
         tty: true
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
        container('builder') {
         
          ansiColor('xterm') {
            sh "docker build -t some:latest ."
          }
         
        }
      }
    }
  }
}
