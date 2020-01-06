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
                                sh 'touch /home/ubuntu/test.txt'
                                sh 'echo `pwd`'
                              }
                      }
                      		
                     }
           }

