pipeline {
    agent any

    environment {
        IMAGE_NAME = 'jenkins-demo'
        IMAGE_TAG = "${BUILD_NUMBER}"
    }

    stages {
        stage('Build') {
            steps {
                sh '''
                    docker build \
                        -t ${IMAGE_NAME}:${IMAGE_TAG} \
                        .
                '''
            }
        }

        stage('Deploy') {
            steps {
                sh '''
                    IMAGE_TAG=${IMAGE_TAG} docker compose up -d
                '''
            }
        }

        stage('Check Deployment'){
            steps {
                sh '''
                    docker compose ps
                '''
            }
        }
    }
}