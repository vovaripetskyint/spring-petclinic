pipeline {
        agent none
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
                      
                    	  
                      		
                     }
           }

