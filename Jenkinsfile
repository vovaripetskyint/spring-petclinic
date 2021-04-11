pipeline {
    agent {
        docker { image 'spellker:latest' }
    }
    stages {
        stage('build') {
            steps {
                sh "pwd"
                sh 'mvn --version'
                sh 'mvn package'
                archiveArtifacts artifacts: '**/target/*.jar'
                
            
                }
               
        }
    }
}

