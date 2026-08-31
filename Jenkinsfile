pipeline {
    agent any

    environment {
        PATH = "/var/lib/jenkins/.local/bin:${env.PATH}"
    }

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