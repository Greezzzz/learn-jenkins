pipeline {
    agent any

    environtment {
        IMAGE_NAME = 'jenkins-demo'
        IMAGE_TAG = "${BUILD_NUMBER}"
    }

    stages {
        stage('Build Docker Image') {
            steps {
                sh '''
                    docker build -t ${IMAGE_NAME}:${IMAGE_TAG} .
                '''
            }
        }

        stage('Run Docker Image') {
            steps {
                sh '''
                    docker run --rm ${IMAGE_NAME}:${IMAGE_TAG}
                '''
            }
        }
    }
}