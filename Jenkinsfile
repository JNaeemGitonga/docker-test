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
                    echo "SEE MY USERNAME : ${GIT_USERNAME}"
                    withCredentials([usernamePassword(credentialsId: '22dc4e90-764b-441e-8024-10357b56831f',, passwordVariable: '${GIT_PASSWORD}', usernameVariable: '${GIT_USERNAME}')]) {
                        sh("git commit -am 'updating version'")
                        sh('git push https://${GIT_USERNAME}:${GIT_PASSWORD}@<REPO>')
                    }
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