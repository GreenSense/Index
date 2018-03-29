pipeline {
    agent any
    triggers {
        pollSCM 'H/2 * * * *'
    }
    stages {
        stage('Setup') {
            steps {
                sh 'curl https://raw.githubusercontent.com/GreenSense/Index/master/setup-from-github.sh | sh -s'
            }
        }
        stage('Test') {
            steps {
                sh 'cd GreenSense/Index'
                sh 'sh test.sh'
            }
        }
    }
    post {
        always {
            cleanWs()
        }
    }
}
