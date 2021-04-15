// Uses Declarative syntax to run commands inside a container.
pipeline {
    agent {
        kubernetes {
            yamlFile 'jenkins_pod.yaml'
            defaultContainer 'jnlp'
        }
    }
    stages {
        stage('Main') {
            steps {
              container('docker-builder') {
                sh 'docker build -t ihaa .'
            }
        }
    }
}
}
