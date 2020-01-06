pipeline {
        agent none
        tools
             {
       		  git 'Default'
       		  maven 'maven'
             }
              stages{
             	  
                      stage('DockerCompose'){
                      agent { label 'docker_slave' }
                         steps{
                                 sh 'docker-compose -f /home/ubuntu/docker-composes/docker-compose.yml up -d'
                              }
                      }
                      		
                     }
           }
