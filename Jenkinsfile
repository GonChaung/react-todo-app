pipeline {
    agent {
        docker {
            // image 'node:lts-buster-slim'
            image 'mrts/docker-python-nodejs-google-chrome'            
            args '-p 3000:3000'
        }
    }

    environment {
        CI = 'true'
    }

    stages {
        stage('Build') {
            steps {
                sh 'npm install'
            }
        }
        stage('Test') {
            steps {
                // start the server
                sh 'npm run test'
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying....'
            }
        }
    }
}