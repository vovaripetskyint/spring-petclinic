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
                                sh 'pwd'
                                sh 'touch /home/ubuntu/test.txt'
                              }
                      }
                      		
                     }
           }

