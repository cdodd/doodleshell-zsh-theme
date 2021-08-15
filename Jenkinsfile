pipeline {
    options {
        ansiColor('xterm')
        buildDiscarder(logRotator(numToKeepStr: '5'))
    }
    agent none
    stages {
        stage('Lint') {
            parallel {
                stage('Terraform') {
                    agent {
                        docker {
                            image 'shellcheck:latest'
                            args '--entrypoint='
                        }
                    }
                    steps {
                        sh 'shellcheck doodleshell.zsh-theme'
                    }
                }
            }
        }
    }
}
