// Uses Declarative syntax to run commands inside a container.
pipeline {
    agent {
        kubernetes {
            yamlFile 'jenkins_pod.yaml'
             yaml '''
apiVersion: v1
kind: Pod
metadata:
spec:
  serviceAccountName: jenkins
  securityContext:
    runAsUser: 0
    fsGroup: 0
  volumes:
    - name: docker-sock
      hostPath:
        path: /var/run/docker.sock
        type: Socket
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
        cpu: 1500m
        memory: 1536Mi
      requests:
        cpu: 1000m
        memory: 1024Mi
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
    AWS_REGION    = "us-east-2"
    ECR_URL       =  "https://676833452478.dkr.ecr.us-east-2.amazonaws.com/myapp"
    IMAGE_TAG     = "676833452478.dkr.ecr.us-east-2.amazonaws.com/myapp:java_v_${env.BUILD_ID}"  
  // VERSION       = getVersion() 
    
  }
    
    
    stages {
        
        stage('Build JAR file by Maven') {
            steps {
                container('maven') {
                sh 'mvn package'
                //  stash(name: "artifact", includes: '**/target/*.jar')
            }
        }
    }
        
        
        stage('Build Docker Image & Push to ECR') {
            steps {
                container('docker-builder') {
                    script{
                        withDockerRegistry(credentialsId: 'ecr:us-east-2:ecr_key', url: "${env.ECR_URL}") {
                             def customImage = docker.build("${env.IMAGE_TAG}")
                             customImage.push()
                        }
                    }
                }
            }
        }
        
        
        
}
}
