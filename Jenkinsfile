pipeline {
    agent none    
    stages {
         stage('Build') {            
           agent {docker { image 'ubuntu_maven:latest' }  }            
            steps {
                sh 'mvn package'
                stash(name: "artifact", includes: '**/target/*.jar')
             //   archiveArtifacts artifacts: '**/target/*.jar'
                  }
            }
          
         stage('Save Artifact') {
            agent any                
            steps {                
                dir('/home/ubuntu/jenkins_artifacts'){
                unstash("artifact")    
                input(message: "Approve deployment based on branch to environment?")
                    
       // Not working but interesting aproach             
       /*         script 
                {
                   docker.image('java:latest').inside('-p 80:80'){}
                }
                sh "java -jar /var/lib/jenkins/workspace/docker/target/spring-petclinic-2.2.0.BUILD-SNAPSHOT-master.jar --server.port=80"
       */
                }                        
            }
        }     
             
             
        stage('Start container with new java image') {            
            agent { dockerfile {additionalBuildArgs  '--build-arg version=1.0.2'} }
             steps {
                sh 'java -jar /var/lib/jenkins/workspace/docker/target/spring-petclinic-2.2.0.BUILD-SNAPSHOT-master.jar --server.port=80'
               
               
             
                  }
            }     
             
    }
        
        
        
        

         

}
