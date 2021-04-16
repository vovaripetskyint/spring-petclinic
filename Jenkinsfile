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
        memory: 3500Mi
      requests:
        cpu: 1000m
        memory: 3024Mi
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
    HELM_CHART_NAME   = "myrepo/app-helm-chart"    
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
                  input(message: "Approve deployment based on branch to environment?")
                }
            }
        }
        
        stage('Deploy Application With New Image to EKS') {
            steps {
                container('helm') {
                sh '''
                helm plugin install https://github.com/hypnoglow/helm-s3.git --version 0.10.0
                helm repo add myrepo $S3_REPOSITORY_URL
                helm repo list 
                helm install prod_app $HELM_CHART_NAME 
                helm upgrade prod_app $HELM_CHART_NAME  --set container.image=$IMAGE_TAG
              '''  
                
                //  stash(name: "artifact", includes: '**/target/*.jar')
            }
        }
    }
        
}
}
