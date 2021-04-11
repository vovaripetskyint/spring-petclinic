pipeline {
    agent none    
    stages {
         stage('build') {            
           agent {docker { image 'ubuntu_maven:latest' }  }            
            steps {
                sh 'mvn package'
                stash(name: "artifact", includes: '**/target/*.jar')
             //   archiveArtifacts artifacts: '**/target/*.jar'
                  }
            }
          
         stage('save artifact') {
            agent any                
            steps {
                
                dir('/home/ubuntu/jenkins_artifacts'){
                unstash("artifact")
                           
                                                     }
                
                
                input(message: "Approve deployment based on branch to environment?")
                script 
                {
                   docker.image('ubuntu_java:latest').inside('-p 80:80'){}
                }
            sh "java -jar /var/lib/jenkins/workspace/docker/target/spring-petclinic-2.2.0.BUILD-SNAPSHOT-master.jar --server.port=80"
                
                  
            }
        }       
    }
        
        
        
        

  }       

