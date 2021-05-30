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
  
  containers:
  - name: mysql
    image: mysql:5.7
    env:
    - name: MYSQL_ROOT_PASSWORD
      value: "petclinic"
    command:
    - cat
    tty: true
  
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
    HELM_CHART_NAME   = "myrepo/application" 
    HELM_HOME         = "/data/helm"
  // VERSION       = getVersion() 
    
  }
    
    
    stages {
        
        stage('MySQL test') {
            steps {
                container('mysql') {
                sh 'apt update && apt install awscli -y'
                sh 'aws sts get-caller-identity'    
                sh 'aws s3 ls'    
            }
        }
    }
     
             
}
}
