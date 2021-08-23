pipeline {
    options {
        ansiColor('xterm')
        buildDiscarder(logRotator(numToKeepStr: '5'))
    }
    agent none
    stages {
        stage('Lint') {
            parallel {
                stage('Shellcheck') {
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
