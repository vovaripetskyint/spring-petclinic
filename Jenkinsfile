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
                                sh 'cp /var/lib/jenkins/workspace/${JOB_NAME}/target/spring-petclinic-2.2.0.BUILD-SNAPSHOT-master.jar ../'
                              }
                      }
                   stage('Build by docker')
                      {
                    	  steps{
                                  dir('test_docker'){sh 'docker build -t myapp .'}

                                sh '$(aws ecr get-login --no-include-email --region us-east-2)' 
                                sh 'docker tag myapp:latest 676833452478.dkr.ecr.us-east-2.amazonaws.com/myapp:java${BUILD_NUMBER}'  
                                sh 'docker push 676833452478.dkr.ecr.us-east-2.amazonaws.com/myapp:java${BUILD_NUMBER}'
                                  } 
                      }
                       
                      
                    }

               
}
