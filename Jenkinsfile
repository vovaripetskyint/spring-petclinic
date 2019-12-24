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
                               git branch: 'master', url: 'https://github.com/VovaRipetsky/spring-petclinic/'
                             }
                      }
                  stage('Build by maven') 
                      {
                         steps{
                    		sh 'mvn package'
                              }
                      }
                   stage('Build by docker')
                      {
                    	  steps{
                                withCredentials([[$class: 'UsernamePasswordMultiBinding', credentialsId: 'aws keys', usernameVariable: 'AWS_ACCESS_KEY_ID', passwordVariable: 'AWS_SECRET_ACCESS_KEY']]){
    
                                sh '$(aws ecr get-login --no-include-email --region us-east-2)' 
                                sh 'docker build -t myapp .'
                                sh 'docker tag myapp:latestpipe 676833452478.dkr.ecr.us-east-2.amazonaws.com/myapp:latestpipe'  
                                sh 'docker push 676833452478.dkr.ecr.us-east-2.amazonaws.com/myapp:latestpipe'
                                }
                      }
                       }
                      
                    }

               
}
