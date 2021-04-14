pipeline {
    agent none    
    
    
    options {
    timeout(time: 3, unit: 'HOURS')
    preserveStashes(buildCount: 1)
    disableConcurrentBuilds()
  }
  environment {
    AWS_REGION    = "us-east-2"
    ECR_URL       = "676833452478.dkr.ecr.us-east-2.amazonaws.com/myapp"
//   VERSION       = getVersion() 
    
  }
    
    
    stages {
         stage('Build') {            
           agent {
               docker {
                   image 'maven:3.6.0-jdk-8-alpine' 
                   args '-v /home/ubuntu/.m2:/root/.m2'
               }  
           }            
            steps {
                sh 'mvn package'
                stash(name: "artifact", includes: '**/target/*.jar')
             //   archiveArtifacts artifacts: '**/target/*.jar'
                  }
            }
        
        stage('Build by docker & push')                      {
            agent {
               docker {
                   image 'docker:latest' 
                 //  args '-v /home/ubuntu/.m2:/root/.m2'
               }    
            }
                         steps{
                              script{
                             //        currentBuild.displayName = getDisplayName(VERSION)
                                     unstash 'artifact'
                                     docker.withRegistry('${ECR_URL}', 'ecr:${AWS_REGION}:ecr_key') 
                                     {
                                     def customImage = docker.build("${ECR_URL}:java_v_${env.BUILD_ID}")
                                     /* Push the container to the custom Registry */
                                     customImage.push()
                                     }
                                    }
                              }
                      
                      }

               }
    
    
  
}
//def getVersion() {
//  shortCommit = sh(returnStdout: true, script: 'git rev-parse --short HEAD').trim()
//  commitCount = sh(returnStdout: true, script: 'git rev-list --count HEAD').trim()
//  return "${commitCount}-${shortCommit}"
//}
