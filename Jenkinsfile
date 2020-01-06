pipeline {
        agent { label 'master' }
        tools
             {
       		  git 'Default'
       		  maven 'maven'
             }
              stages{
             	  stage('Clone')
                      {
                    	steps{
                               git branch: 'compose', url: 'https://github.com/VovaRipetsky/spring-petclinic/'
                             }
                      }
              	     stage('Build') 
                      {
                         steps{
                    		sh 'mvn clean package'
                              }
                      }
                      stage('Deploy')
                      {
                         steps{
                        sh 'scp -i /var/lib/jenkins/.ssh/id_rsa -o StrictHostKeyChecking=no /var/lib/jenkins/workspace/pipe_mvn_jar/target/*.jar ubuntu@172.31.24.91:/home/ubuntu/docker-composes'

                              }
                      }
                    	  
                      		
                     }
           }

