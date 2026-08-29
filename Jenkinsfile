pipeline {
    agent any

    stages {
        stage('Build Docker Image') {
            steps {
                sh '''
                    docker build -t learn-jenkins:latest .
                '''
            }
        }

        stage('Run Docker Image') {
            steps {
                sh '''
                    docker run --rm learn-jenkins:latest
                '''
            }
        }
    }
}