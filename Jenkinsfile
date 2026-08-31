pipeline {
    agent any

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Install Dependencies') {
            steps {
                sh '''
                    uv sync --frozen
                '''
            }
        }

        stage('Test') {
            steps {
                sh '''
                    uv run pytest
                '''
            }
        }

    }
}