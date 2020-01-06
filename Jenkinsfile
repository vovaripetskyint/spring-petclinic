pipeline {
        agent any
        tools
             {
       		  git 'Default'
       		  maven 'Maven-3-6-1'
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
}
