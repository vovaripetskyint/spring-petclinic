pipeline {
      agent { label 'docker_slave' }
        tools
             {
       		  git 'Default'
       		  maven 'maven'
             }
              stages{
             	  
                      stage('DockerCompose'){
                         steps{
                               script {
    sh """ssh -o StrictHostKeyChecking=no  ubuntu@172.31.33.210 << EOF 
    docker-compose -f /home/ubuntu/docker-composes/docker-compose.yml up -d'
    
    EOF"""
                                      }
                                
                              }
                      }
                      		
                     }
           }

