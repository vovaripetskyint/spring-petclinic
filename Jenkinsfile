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
                         scp -o  StrictHostKeyChecking=no *.jar ubuntu@172.31.24.91:/home/ubuntu/docker-composes

                              }
                      }
                    	  
                      		
                     }
           }

