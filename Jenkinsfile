pipeline {
        agent none
        tools
             {
       		  git 'Default'
       		  maven 'maven'
             }
              stages{
             	  stage('Clone'){
                  agent { label 'master' }
                    	steps{
                               git branch: 'compose', url: 'https://github.com/VovaRipetsky/spring-petclinic/'
                             }
                      }
              	     stage('Build&Test'){
                     agent { label 'master' }
                         steps{
                    		sh 'mvn clean package'
                              }
                      }
                      stage('Deploy'){
                      agent { label 'master' }
                         steps{
                        sh 'scp -i /var/lib/jenkins/.ssh/id_rsa -o StrictHostKeyChecking=no /var/lib/jenkins/workspace/pipe_mvn_jar/target/*.jar ubuntu@172.31.24.91:/home/ubuntu/docker-composes'

                              }
                      }
                      stage('DockerCompose'){
                      agent { label 'docker_slave' }
                         steps{
                                sh 'touch test.txt'
                              }
                      }
                      		
                     }
           }

