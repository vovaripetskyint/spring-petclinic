// Uses Declarative syntax to run commands inside a container.
pipeline {
    agent {
        kubernetes {
            
             yaml '''
apiVersion: v1
kind: Pod
metadata:
spec:
  serviceAccountName: myjenkins
  securityContext:
    runAsUser: 0
    fsGroup: 0
  volumes:
    - name: docker-sock
      hostPath:
        path: /var/run/docker.sock
        type: Socket
    - name: pv-dynamic-storage
      persistentVolumeClaim:
        claimName: pvc-dynamic
  containers:
  - name: helm
    image: alpine/helm:3.5.2
    command:
    - cat
    tty: true
  - name: maven
    image: maven:3.6.0-jdk-8-alpine
    command:
    - cat
    tty: true
    resources:
      limits:
        cpu: 1700m
        memory: 1536Mi
      requests:
        cpu: 1000m
        memory: 1024Mi
    volumeMounts:
    - mountPath: "/root/.m2"
      name: pv-dynamic-storage
  - name: docker-builder
    image: 'docker:latest'
    command:
    - cat
    tty: true
    volumeMounts:
    - name: docker-sock
      mountPath: /run/docker.sock
'''
        }
    }
    
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
    HELM_CHART_NAME   = "myrepo2/application-ing" 
    HELM_HOME         = "/data/helm"
  // VERSION       = getVersion() 
    
  }
    
    
    stages {
        
        stage('Build JAR file by Maven') {
            steps {
                container('maven') {
                sh 'mvn -DskipTests=true package'
                //  stash(name: "artifact", includes: '**/target/*.jar')
            }
        }
    }
        
        
        
        stage('Build Docker Image & Push to ECR') {
            steps {
                container('docker-builder') {
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
                    
                helm repo add myrepo2 $S3_REPOSITORY_URL
                helm repo update
                helm repo list 
                helm upgrade --install backend $HELM_CHART_NAME  --set container.image=$IMAGE_TAG --set replicaCount=1
              '''  
               
                //  stash(name: "artifact", includes: '**/target/*.jar')
            }
               
        }
    }
             
}
}
