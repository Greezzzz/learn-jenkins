pipeline {
    agent any

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Debug Environment') {
            steps {
                sh '''
                    whoami
                    echo "HOME=$HOME"
                    echo "PATH=$PATH"
                    command -v uv || true
                    ls -la "$HOME/.local/bin" || true
                '''
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