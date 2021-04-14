#!/bin/groovy
pipeline {
  agent {
    kubernetes {
      defaultContainer 'jnlp'
      yaml """\
       apiVersion: v1
       kind: Pod
       metadata:
       spec:
         serviceAccountName: jenkins
         securityContext:
           runAsUser: 0
           fsGroup: 0
     
       containers:
       - name: docker-builder
         image: 'docker:18-git'
         command:
         - cat
         tty: true
         
         """.stripIndent()
    }
  }
  options {
    timeout(time: 3, unit: 'HOURS')
    preserveStashes(buildCount: 1)
    disableConcurrentBuilds()
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
