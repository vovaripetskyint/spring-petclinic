pipeline {
        agent none
        tools
             {
       		  git 'Default'
       		  maven 'maven'
             }
              stages{
             	  stage('Clone Git JAR'){
                  agent { label 'master' }
                    	steps{
                               git branch: 'compose', url: 'https://github.com/VovaRipetsky/spring-petclinic/'
                             }
                      }
              	     stage('Build&Test JAR'){
                     agent { label 'master' }
                         steps{
                    		sh 'mvn clean package'
                              }
                      }
                      stage('Deploy JAR'){
                      agent { label 'master' }
                         steps{
                        withCredentials([sshUserPrivateKey(credentialsId: "sshdocker", keyFileVariable: 'keyfile')]) {           
                        sh 'scp -i ${keyfile} -o StrictHostKeyChecking=no /var/lib/jenkins/workspace/pipe_mvn_jar/target/*.jar ubuntu@172.31.44.188:/home/ubuntu/docker-composes/java'

                              }
                      }
                      }
                                         
                      
                      stage('DockerCompose'){
                      agent { label 'docker_slave' }
                         steps{
                                sh 'docker-compose -f /home/ubuntu/docker-composes/java/docker-compose-java.yml up -d'
                                sh 'docker-compose -f /home/ubuntu/docker-composes/java/docker-compose-java.yml restart'

                              }
                      }
                      		
                     }
           }
