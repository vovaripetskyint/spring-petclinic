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
                                sh 'ssh -o StrictHostKeyChecking=no ubuntu@172.31.24.91 '
                                docker-compose -f /home/ubuntu/docker-composes/docker-compose.yml up -d''
                              }
                      }
                      		
                     }
           }
