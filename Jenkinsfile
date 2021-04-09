pipeline {
        agent any
        tools
             {
       		  git 'Default'
       		  maven 'maven'
             }
              stages{
             	  stage('Clone repository')
                      {
                    	steps{
                                checkout scm
                             }
                      }
                  stage('Build by maven') 
                      {
                         steps{
                    		sh 'mvn package'
                                sh "pwd"
                                sh 'cp /var/lib/jenkins/workspace/${JOB_NAME}/target/spring-petclinic-2.2.0.BUILD-SNAPSHOT-master.jar ./'
                              }
                      }
                   stage('Build by docker')
                      {
                    	   docker.withRegistry('https://676833452478.dkr.ecr.us-east-2.amazonaws.com/myapp', 'ecr') {

                           def customImage = docker.build("myapp:${env.BUILD_ID}")

                           /* Push the container to the custom Registry */
                           customImage.push()
    }
                      }
                       
                      
                    }

               
}
