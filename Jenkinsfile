pipeline {
    agent any

    environment {
        IMAGE_NAME = 'jenkins-demo'
        IMAGE_TAG = "${BUILD_NUMBER}"
        DEPLOY_DIR = '/opt/jenkins-demo'
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
                    mkdir -p ${DEPLOY_DIR}

                    cp compose.yaml ${DEPLOY_DIR}/compose.yaml

                    cat > ${DEPLOY_DIR}/deployment.env <<EOF
IMAGE_TAG=${IMAGE_TAG}
EOF

                    cd ${DEPLOY_DIR}

                    docker compose up -d
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

        stage('Commit Deployment State') {
            steps {
                sh '''
                    GIT_COMMIT=$(git rev-parse HEAD)

                    cat > ${DEPLOY_DIR}/deployment.env <<EOF
IMAGE_TAG=${IMAGE_TAG}
GIT_COMMIT=${GIT_COMMIT}
EOF

                    echo "Deployment committed."
                    cat ${DEPLOY_DIR}/deployment.env
                '''
            }
        }
    }
}