pipeline {
        agent any
        tools
             {
       		  git 'Default'
       		  maven 'Maven-3-6-1'
             }
              stages{
             	  stage('Clone repository')
                      {
                    	steps{
                               git branch: 'master', url: 'https://github.com/VovaRipetsky/spring-petclinic/'
                             }
                      }
              	     stage('Build by maven') 
                      {
                         steps{
                    		sh 'mvn package'
                              }
                      }
                      stage('Build by docker'){
                    	  steps{
                      		dockerfile {
                                filename 'Dockerfile'
                                label 'my-defined-label'
                                registryUrl '676833452478.dkr.ecr.us-east-2.amazonaws.com/myapp'
                                registryCredentialsId 'AKIAZ3FTK4G7KSIDNPZP'
                                        }
                                }

                       }
}
