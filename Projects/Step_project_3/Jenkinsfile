pipeline {
    agent { label 'jenkins_worker_1' }
    environment {
        DOCKER_CREDENTIALS_ID = 'DockerHub_Module2'
        DOCKER_IMAGE_NAME = 'sashaloven/module_2' // Your Docker Hub repository
        DOCKER_TAG = 'latest' // Tag for the image
        CONTAINER_NAME = 'app_js' // Name of your Docker container
    }
    
    stages {
        stage ('Pull') {
            steps {
             git url: 'https://github.com/sashaloven/CI_CD_Project', branch: 'main'   
            }
        }
        
        stage ('Build') {
            steps {
                sh 'chmod +x Step_Project_2/tests'
                dir('Step_Project_2') {
                sh 'docker build -t ${DOCKER_IMAGE_NAME}:${DOCKER_TAG} .'
                }
            }
        }
        
        stage('Run') {
            steps {
                // Run the Docker container in detached mode
                dir('Step_Project_2') {
                sh 'docker run -d --name ${CONTAINER_NAME} -p 3000:3000 -p 80:80 ${DOCKER_IMAGE_NAME}' 
                }
            }
        }
        
         stage('Test') {
            steps {
                dir('Step_Project_2/tests') {
                    script {
                        try {
                            sh 'npm install'
                            sh 'npm test'
                        } catch (Exception e) {
                            echo 'Test Failed'
                        }
                    }
                }
            }
         }
         
          stage('Push to Docker Hub') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', "${DOCKER_CREDENTIALS_ID}") {
                        sh 'docker push ${DOCKER_IMAGE_NAME}:${DOCKER_TAG}'
                    }
                }
            }
        }
        
        stage('Clear Docker Containers and Images') {
            steps {
                script {
                    sh 'docker rm -f ${CONTAINER_NAME}'
                    sh 'docker rmi ${DOCKER_IMAGE_NAME}:${DOCKER_TAG} || true'
                }
            }
        }
    }
}
