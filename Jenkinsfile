pipeline {
    agent {
        docker { image 'spellker:latest' }
    }
    stages {
        stage('build') {
            steps {
                sh "pwd"
                sh 'mvn --version'
               // sh "git clone https://github.com/VovaRipetsky/spring-petclinic.git"
                sh 'mvn package'
                //sh 'mvn -f /var/lib/jenkins/workspace/docker/spring-petclinic package'
                archiveArtifacts artifacts: '*.jar'
                
            
                }
               
        }
    }
}

