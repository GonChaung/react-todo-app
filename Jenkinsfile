pipeline {
  agent any

  environment {
    // Make Homebrew + Docker available to Jenkins service
    PATH = "/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"

    DOCKER_HUB_USER  = 'gonchaung'
    IMAGE_NAME       = 'finead-todo-app'
    DOCKER_HUB_CREDS = 'docker-hub-credentials'
  }

  stages {
    stage('Build') {
      steps {
        sh 'node -v'
        sh 'npm -v'
        sh 'npm ci'
      }
    }

    stage('Test') {
      steps {
        sh 'npm test'
      }
    }

    stage('Containerize') {
      steps {
        sh 'docker --version'
        sh "docker build -t ${DOCKER_HUB_USER}/${IMAGE_NAME}:latest ."
      }
    }

    stage('Push') {
      steps {
        withCredentials([usernamePassword(credentialsId: "${DOCKER_HUB_CREDS}", usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
          sh 'echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin'
          sh "docker push ${DOCKER_HUB_USER}/${IMAGE_NAME}:latest"
        }
      }
    }
  }
}