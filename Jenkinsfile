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
           //     sh 'apt update && apt install awscli -y'
           //     sh 'aws sts get-caller-identity'  
                sh '''
                 apt update && apt install awscli curl -y
                 JQ=/usr/bin/jq && curl https://stedolan.github.io/jq/download/linux64/jq > $JQ && chmod +x $JQ
                 
              ''' 
                sh '''
                 set +x   
                 aws sts assume-role-with-web-identity \
 --role-arn $AWS_ROLE_ARN \
 --role-session-name mh9test \
 --web-identity-token file://$AWS_WEB_IDENTITY_TOKEN_FILE \
 --duration-seconds 1000 > /tmp/irp-cred.txt
 export AWS_ACCESS_KEY_ID="$(cat /tmp/irp-cred.txt | jq -r ".Credentials.AccessKeyId")"
 export AWS_SECRET_ACCESS_KEY="$(cat /tmp/irp-cred.txt | jq -r ".Credentials.SecretAccessKey")"
 export AWS_SESSION_TOKEN="$(cat /tmp/irp-cred.txt | jq -r ".Credentials.SessionToken")"
 rm /tmp/irp-cred.txt
 aws sts get-caller-identity
 aws s3 ls
              '''      
               
                sh 'aws sts get-caller-identity'    
            }
        }
    }
     
             
}
}
