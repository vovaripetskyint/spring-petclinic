pipeline {
        agent any
        tools
             {
       		  git 'Default'
       		  maven 'Maven'
             }
              stages{
             	  stage('Clone repository')
                      {
                    	steps{
                               git branch: 'all_tasks', url: 'https://github.com/VovaRipetsky/spring-petclinic/'
                             }
                      }
                  stage('Build by maven') 
                      {
                         steps{
                    		sh 'mvn package'
                                sh 'cp /var/lib/jenkins/workspace/${JOB_NAME}/target/spring-petclinic-2.2.0.BUILD-SNAPSHOT-master.jar ../'
                              }
                      }
                   stage('Build by docker')
                      {
                    	  steps{
                                  dir('src'){sh 'docker build -t myapp .'}

                                sh '$(aws ecr get-login --no-include-email --region us-east-2)' 
                                sh 'docker tag myapp:latest 676833452478.dkr.ecr.us-east-2.amazonaws.com/myapp:java${BUILD_NUMBER}'  
                                sh 'docker push 676833452478.dkr.ecr.us-east-2.amazonaws.com/myapp:java${BUILD_NUMBER}'
                                  } 
                      }
                       
                      
                    }

               
}
