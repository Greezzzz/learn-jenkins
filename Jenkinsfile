pipeline {
    agent any

    environment {
        IMAGE_NAME = 'jenkins-demo'
        IMAGE_TAG = "${BUILD_NUMBER}"
        STATE_FILE = 'deployment-state.env'
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

        stage('Get Current Version') {
            steps {
                script {
                    if (fileExists(env.STATE_FILE)) {
                        def state = readFile(env.STATE_FILE).trim()

                        if (state) {
                            env.PREVIOUS_VERSION = 
                                state.replace('CURRENT_VERSION=', '').trim()
                        }
                    }

                    if (!env.PREVIOUS_VERSION) {
                        env.PREVIOUS_VERSION = ''
                    }

                    echo "Previous version: ${env.PREVIOUS_VERSION}"
                    echo "New version: ${env.IMAGE_TAG}"
                }
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

        stage('Update Deployment State') {
            steps {
                sh '''
                    echo "CURRENT_VERSION=${IMAGE_TAG}" > %{STATE_FILE}

                    echo "Deployment state updated:"
                    cat ${STATE_FILE}
                '''
            }
        }
    }

    post {
        failure {
            script {
                if (env.PREVIOUS_VERSION) {
                    echo "Deployment failed !"
                    echo "Rolling back to ${env.PREVIOUS_VERSION}"

                    sh """
                        IMAGE_TAG = ${PREVIOUS_VERSION} docker compose up -d
                    """
                } else {
                    echo "No previous version available. Skipping rollback."
                }
            }
        }
    }
}