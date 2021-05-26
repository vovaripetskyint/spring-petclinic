// Uses Declarative syntax to run commands inside a container.
pipeline {
    
    
    options {
    timeout(time: 3, unit: 'HOURS')
    preserveStashes(buildCount: 1)
    disableConcurrentBuilds()
  }
    environment {
    AWS_REGION        = "us-east-2"
    ECR_URL           = "https://676833452478.dkr.ecr.us-east-2.amazonaws.com/myapp"
    IMAGE_TAG         = "676833452478.dkr.ecr.us-east-2.amazonaws.com/myapp:java_v_${env.BUILD_ID}"  
    S3_REPOSITORY_URL = "s3://myvovastartup/Helm"    
    HELM_CHART_NAME   = "myrepo/application" 
    HELM_HOME         = "/data/helm"
  // VERSION       = getVersion() 
    
  }
    
    
    stages {
        
        stage('Build JAR file by Maven') {
            agent {
                  kubernetes {
                  defaultContainer 'jnlp'
                  yamlFile 'jenkins_pod_fargate.yml'
                  slaveConnectTimeout 180
        }
      }
            steps {
                container('maven-fargate') {
                sh 'mvn -DskipTests=true package'
                //  stash(name: "artifact", includes: '**/target/*.jar')
            }
        }
    }
        
        
        
        stage('Build Docker Image & Push to ECR') {
            agent {
                  kubernetes {
                  defaultContainer 'jnlp'
                  yamlFile 'jenkins_pod_fargate.yml'
                  slaveConnectTimeout 180
        }
      }
            steps {
                container('docker-builder-fargate') {
                   sh """#!/bin/sh
              set -xe
              apk update
                      
              
             apk add --no-cache \
             python3 \
             py3-pip \
             && pip3 install --upgrade pip \
             && pip3 install \
             awscli \
             && rm -rf /var/cache/apk/*
              
              docker build -t ${IMAGE_TAG} .
              set +x
              \$(aws ecr get-login --no-include-email --region ${AWS_REGION})
              set -x
              docker push ${IMAGE_TAG}
              
            """
             //     input(message: "Approve deployment based on branch to environment?")
                }
            }
        }
        
        
        
   //ECR PLUGIN:     
   /**   
        stage('Build Docker Image & Push to ECR') {
            steps {
                container('docker-builder') {
                    script{
                        withDockerRegistry(credentialsId: 'ecr:us-east-2:ecr_key', url: "${env.ECR_URL}") {
                             def customImage = docker.build("${env.IMAGE_TAG}")
                             customImage.push()
                        }
                    }
             //     input(message: "Approve deployment based on branch to environment?")
                }
            }
        }
       */
        
      
        
        
        stage('Deploy Application With New Image to EKS') {
            agent {
                  kubernetes {
                  defaultContainer 'jnlp'
                  yamlFile 'jenkins_pod.yml'
                  slaveConnectTimeout 180
        }
      }
            steps {
                container('helm') {
               
                 sh """#!/bin/sh
              set -xe
              apk --update --no-cache add \
                git \
                bash
              mkdir -p $HELM_HOME/plugins \
                && helm plugin install https://github.com/hypnoglow/helm-s3.git --version 0.10.0
            """    
                    
                                                    
                sh '''
                    
                helm repo add myrepo $S3_REPOSITORY_URL
                helm repo list 
                helm upgrade --install prodapp $HELM_CHART_NAME  --set container.image=$IMAGE_TAG --set replicaCount=1
              '''  
               
                //  stash(name: "artifact", includes: '**/target/*.jar')
            }
               
        }
    }
             
}
}
