pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Environtment Check') {
            steps {
                sh '''
                    echo "==== GIT ==="
                    git --version--

                    echo "=== Docker ==="
                    docker --version

                    echo "=== Docker Compose ==="
                    docker compose version
                '''
            }
        }

        stage('Docker Check') {
            steps {
                sh '''
                    echo "=== Container ==="
                    docker ps
                '''
            }
        }
    }
}