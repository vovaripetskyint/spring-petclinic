pipeline {
    agent none    
    stages {
         stage('build') {            
           agent {docker { image 'spellker:latest' }  }            
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
                unstash("artifact")
                sh "pwd"
                input(message: "Approve deployment based on branch to environment?")
                sh "java -jar '**/target/*.jar'"
                  
            }
        }       
    }
        
        
        
        

  }       

