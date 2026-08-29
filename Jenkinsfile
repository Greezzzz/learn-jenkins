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

        stage('Health Check'){
            steps {
                sh '''
                    echo "Waiting for application..."

                    sleep 3

                    curl --fail \
                        http://localhost:8081

                    echo ""
                    echo "Application is healty!"
                '''
            }
        }
    }
}