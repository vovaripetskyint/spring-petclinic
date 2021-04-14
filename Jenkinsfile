pipeline {
    agent none    
    stages {
         stage('Build') {            
           agent {
               docker {
                   image 'maven:3.6.0-jdk-8-alpine' 
                   args '-v /home/ubuntu/.m2:/root/.m2'
               }  
           }            
            steps {
                sh 'mvn package'
                stash(name: "artifact", includes: '**/target/*.jar')
             //   archiveArtifacts artifacts: '**/target/*.jar'
                  }
            }
    }
    
}
