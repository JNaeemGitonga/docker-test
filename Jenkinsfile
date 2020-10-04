def gv

pipeline {
    agent any
    parameters {

        choice(name: "release", choices: [true, false])
    }

    stages {
        stage("main") {
            steps {
                script {
                    gv = load "script.groovy"
                    gv.bumpVersion()
                }
            }
        }
        stage("build") {
            steps {
                script {
                    echo "MAKING THE BUILD"
                }
            }
        }
        stage("finish") {
            steps {
                script {
                    gv.commitAndPush()
                }
            }
        }
    }
}