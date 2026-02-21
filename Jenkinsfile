pipeline {
    agent any

    environment {
        DOCKER_HUB_USER  = 'gonchaung'
        IMAGE_NAME       = 'react-todo-app'
        DOCKER_HUB_CREDS = 'docker-hub-credentials'
    }

    stages {
        stage('Build') {
            steps {
                echo 'Building the application...'
                sh 'npm ci'
            }
        }

        stage('Test') {
            steps {
                echo 'Running unit tests...'
                sh 'npm test'
            }
        }

        stage('Containerize') {
            steps {
                echo 'Creating Docker image...'
                sh "docker build -t ${DOCKER_HUB_USER}/${IMAGE_NAME}:latest ."
            }
        }

        stage('Push') {
            steps {
                echo 'Logging into Docker Hub and pushing image...'
                withCredentials([usernamePassword(
                    credentialsId: "${DOCKER_HUB_CREDS}",
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS'
                )]) {
                    sh 'echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin'
                    sh "docker push ${DOCKER_HUB_USER}/${IMAGE_NAME}:latest"
                }
            }
        }
    }

    post {
        always {
            echo 'Cleaning up workspace...'
            sh "docker logout || true"
            sh "docker rmi ${DOCKER_HUB_USER}/${IMAGE_NAME}:latest || true"
        }
    }
}