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
                               git branch: 'master', url: 'https://github.com/VovaRipetsky/spring-petclinic/'
                             }
                      }
              	     stage('Build') 
                      {
                         steps{
                    		sh 'mvn package'
                              }
                      }
                      stage('Deploy'){
                    	  steps{
                      		rtUpload (    
                    		serverId: 'jfrog',spec: '''{
               			                        "files": [
               	     		                           {
                		                                "pattern": "*.jar",
                   	                                	"target": "example-repo-local/"
                             		                   }
                             				         ]
					 		  }
                                                       '''
                                        )
                               }
                                    }
           }
}
