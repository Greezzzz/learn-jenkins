pipeline {
    agent any

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Test') {
            steps {
                sh '''
                    python -m pytest
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