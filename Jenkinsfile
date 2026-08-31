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

        stage('Test') {
            steps {
                sh '''
                    uv run python -m pytest ./test/test_health.py
                '''
            }
        }

        stage('Deploy') {
            steps {
                sshagent(['vps-ssh']) {
                    sh '''
                        rsync -avz --delete \
                            --exclude='.git' \
                            ./ ubuntu@43.129.33.101:/opt/health-api/

                        ssh ubuntu@43.129.33.101 "
                            cd /opt/health-api &&
                            docker compose up -d --build
                        "
                    '''
                }
            }
        }
    }
}