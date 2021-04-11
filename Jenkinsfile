pipeline {
    agent none    
    stages {
         stage('build') {            
           agent {docker { image 'java:latest' }  }            
            steps {
                sh "pwd"
                sh 'mvn --version'
                sh 'mvn package'
                stash(name: "artifact", includes: '**/target/*.jar')
             //   archiveArtifacts artifacts: '**/target/*.jar'
                  }
            }
          
         stage('deploy') {
            agent {
                docker { image 'java:latest' }  }
            steps {
                sh 'java -v'
                unstash("artifact")
                sh "pwd"
            }
        }       
    }
        
        
        
        

  }       
}
