pipeline {
        agent any
        tools
             {
       		  git 'Default'
       		  maven 'maven'
             }
              stages{
             	  stage('Clone repository')
                      {
                    	steps{
                                checkout scm
                             }
                      }
                  stage('Build by maven') 
                      {
                         steps{
                    		sh 'mvn package'
                                sh "pwd"
                                sh 'cp /var/lib/jenkins/workspace/${JOB_NAME}/target/spring-petclinic-2.2.0.BUILD-SNAPSHOT-master.jar ./'
                              }
                      }
                   stage('Build by docker')
                      {
                    	  steps{
                                sh 'docker build -t myapp .'
                                sh 'docker tag myapp:latest 676833452478.dkr.ecr.us-east-2.amazonaws.com/myapp:java_ver_${BUILD_NUMBER}'
                                  script{
                                docker.withRegistry('https://676833452478.dkr.ecr.us-east-2.amazonaws.com', 'ecr:us-east-2:ecr') {
                                        docker.image('676833452478.dkr.ecr.us-east-2.amazonaws.com/myapp').push('java${BUILD_NUMBER}')
  }
                                  }
                                  } 
                      }
                       
                      
                    }

               
}
