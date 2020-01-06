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
                                sh 'touch test.txt'
                              }
                      }
                      		
                     }
           }

