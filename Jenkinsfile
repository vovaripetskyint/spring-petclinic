pipeline {
    agent none    
    stages {
         stage('Build') {            
           agent {
               docker {
                   image 'maven:3.6.0-jdk-8-alpine' }  }            
            steps {
                sh 'mvn package'
                stash(name: "artifact", includes: '**/target/*.jar')
             //   archiveArtifacts artifacts: '**/target/*.jar'
                  }
            }
    }
    
}
